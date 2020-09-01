Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03BE25890C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 09:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgIAHbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 03:31:44 -0400
Received: from regular1.263xmail.com ([211.150.70.197]:57552 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgIAHbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 03:31:44 -0400
Received: from localhost (unknown [192.168.167.32])
        by regular1.263xmail.com (Postfix) with ESMTP id 64982D82;
        Tue,  1 Sep 2020 15:30:19 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED: 0
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.39] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P11836T140500728280832S1598945415326857_;
        Tue, 01 Sep 2020 15:30:16 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <5980efa4ed0b2cbc37153d642df00589>
X-RL-SENDER: algea.cao@rock-chips.com
X-SENDER: algea.cao@rock-chips.com
X-LOGIN-NAME: algea.cao@rock-chips.com
X-FST-TO: linux-rockchip@lists.infradead.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Subject: Re: [PATCH] drm: Parse Colorimetry data block from EDID
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     mripard@kernel.org, tzimmermann@suse.de,
        linux-kernel@vger.kernel.org, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
        daniel@ffwll.ch, linux-rockchip@lists.infradead.org
References: <20200826142328.131144-1-algea.cao@rock-chips.com>
 <20200827105701.GS6112@intel.com>
 <4cadf318-cfc3-92d6-6219-170166db94ce@rock-chips.com>
 <20200831195316.GC6112@intel.com>
From:   crj <algea.cao@rock-chips.com>
Message-ID: <7a800d9f-2679-73a6-f3d3-dd6cfa829790@rock-chips.com>
Date:   Tue, 1 Sep 2020 15:30:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200831195316.GC6112@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2020/9/1 3:53, Ville Syrjälä 写道:
> On Fri, Aug 28, 2020 at 09:07:13AM +0800, crj wrote:
>> Hi Ville Syrjälä,
>>
>> 在 2020/8/27 18:57, Ville Syrjälä 写道:
>>> On Wed, Aug 26, 2020 at 10:23:28PM +0800, Algea Cao wrote:
>>>> CEA 861.3 spec adds colorimetry data block for HDMI.
>>>> Parsing the block to get the colorimetry data from
>>>> panel.
>>> And what exactly do you want to do with that data?
>>
>> We can get colorimetry data block from edid then support
>>
>> HDMI colorimetry such as BT2020.
> But what do you want to do with it? The patch does nothing
> functional.

If we want to output BT2020 in HDMI driver, we can know whether TV 
support BT2020

via connector->display_info.hdmi.colorimetry. If TV don't support 
BT2020, HDMI shouldn't

ouput in BT2020.

>>>> Signed-off-by: Algea Cao <algea.cao@rock-chips.com>
>>>> ---
>>>>
>>>>    drivers/gpu/drm/drm_edid.c  | 45 +++++++++++++++++++++++++++++++++++++
>>>>    include/drm/drm_connector.h |  3 +++
>>>>    include/drm/drm_edid.h      | 14 ++++++++++++
>>>>    3 files changed, 62 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
>>>> index 31496b6cfc56..67e607c04492 100644
>>>> --- a/drivers/gpu/drm/drm_edid.c
>>>> +++ b/drivers/gpu/drm/drm_edid.c
>>>> @@ -3223,6 +3223,7 @@ add_detailed_modes(struct drm_connector *connector, struct edid *edid,
>>>>    #define VIDEO_BLOCK     0x02
>>>>    #define VENDOR_BLOCK    0x03
>>>>    #define SPEAKER_BLOCK	0x04
>>>> +#define COLORIMETRY_DATA_BLOCK		0x5
>>>>    #define HDR_STATIC_METADATA_BLOCK	0x6
>>>>    #define USE_EXTENDED_TAG 0x07
>>>>    #define EXT_VIDEO_CAPABILITY_BLOCK 0x00
>>>> @@ -4309,6 +4310,48 @@ static void fixup_detailed_cea_mode_clock(struct drm_display_mode *mode)
>>>>    	mode->clock = clock;
>>>>    }
>>>>    
>>>> +static bool cea_db_is_hdmi_colorimetry_data_block(const u8 *db)
>>>> +{
>>>> +	if (cea_db_tag(db) != USE_EXTENDED_TAG)
>>>> +		return false;
>>>> +
>>>> +	if (db[1] != COLORIMETRY_DATA_BLOCK)
>>>> +		return false;
>>>> +
>>>> +	if (cea_db_payload_len(db) < 2)
>>>> +		return false;
>>>> +
>>>> +	return true;
>>>> +}
>>>> +
>>>> +static void
>>>> +drm_parse_colorimetry_data_block(struct drm_connector *connector, const u8 *db)
>>>> +{
>>>> +	struct drm_hdmi_info *info = &connector->display_info.hdmi;
>>>> +
>>>> +	if (db[2] & DRM_EDID_CLRMETRY_xvYCC_601)
>>>> +		info->colorimetry |= DRM_EDID_CLRMETRY_xvYCC_601;
>>>> +	if (db[2] & DRM_EDID_CLRMETRY_xvYCC_709)
>>>> +		info->colorimetry |= DRM_EDID_CLRMETRY_xvYCC_709;
>>>> +	if (db[2] & DRM_EDID_CLRMETRY_sYCC_601)
>>>> +		info->colorimetry |= DRM_EDID_CLRMETRY_sYCC_601;
>>>> +	if (db[2] & DRM_EDID_CLRMETRY_ADBYCC_601)
>>>> +		info->colorimetry |= DRM_EDID_CLRMETRY_ADBYCC_601;
>>>> +	if (db[2] & DRM_EDID_CLRMETRY_ADB_RGB)
>>>> +		info->colorimetry |= DRM_EDID_CLRMETRY_ADB_RGB;
>>>> +	if (db[2] & DRM_EDID_CLRMETRY_BT2020_CYCC)
>>>> +		info->colorimetry |= DRM_EDID_CLRMETRY_BT2020_CYCC;
>>>> +	if (db[2] & DRM_EDID_CLRMETRY_BT2020_YCC)
>>>> +		info->colorimetry |= DRM_EDID_CLRMETRY_BT2020_YCC;
>>>> +	if (db[2] & DRM_EDID_CLRMETRY_BT2020_RGB)
>>>> +		info->colorimetry |= DRM_EDID_CLRMETRY_BT2020_RGB;
>>>> +	/* Byte 4 Bit 7: DCI-P3 */
>>>> +	if (db[3] & BIT(7))
>>>> +		info->colorimetry |= DRM_EDID_CLRMETRY_DCI_P3;
>>>> +
>>>> +	DRM_DEBUG_KMS("Supported Colorimetry 0x%x\n", info->colorimetry);
>>>> +}
>>>> +
>>>>    static bool cea_db_is_hdmi_hdr_metadata_block(const u8 *db)
>>>>    {
>>>>    	if (cea_db_tag(db) != USE_EXTENDED_TAG)
>>>> @@ -4994,6 +5037,8 @@ static void drm_parse_cea_ext(struct drm_connector *connector,
>>>>    			drm_parse_vcdb(connector, db);
>>>>    		if (cea_db_is_hdmi_hdr_metadata_block(db))
>>>>    			drm_parse_hdr_metadata_block(connector, db);
>>>> +		if (cea_db_is_hdmi_colorimetry_data_block(db))
>>>> +			drm_parse_colorimetry_data_block(connector, db);
>>>>    	}
>>>>    }
>>>>    
>>>> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
>>>> index af145608b5ed..d599c3b9e881 100644
>>>> --- a/include/drm/drm_connector.h
>>>> +++ b/include/drm/drm_connector.h
>>>> @@ -207,6 +207,9 @@ struct drm_hdmi_info {
>>>>    
>>>>    	/** @y420_dc_modes: bitmap of deep color support index */
>>>>    	u8 y420_dc_modes;
>>>> +
>>>> +	/* @colorimetry: bitmap of supported colorimetry modes */
>>>> +	u16 colorimetry;
>>>>    };
>>>>    
>>>>    /**
>>>> diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
>>>> index cfa4f5af49af..98fa78c2f82d 100644
>>>> --- a/include/drm/drm_edid.h
>>>> +++ b/include/drm/drm_edid.h
>>>> @@ -229,6 +229,20 @@ struct detailed_timing {
>>>>    				    DRM_EDID_YCBCR420_DC_36 | \
>>>>    				    DRM_EDID_YCBCR420_DC_30)
>>>>    
>>>> +/*
>>>> + * Supported Colorimetry from colorimetry data block
>>>> + * as per CEA 861-G spec
>>>> + */
>>>> +#define DRM_EDID_CLRMETRY_xvYCC_601   (1 << 0)
>>>> +#define DRM_EDID_CLRMETRY_xvYCC_709   (1 << 1)
>>>> +#define DRM_EDID_CLRMETRY_sYCC_601    (1 << 2)
>>>> +#define DRM_EDID_CLRMETRY_ADBYCC_601  (1 << 3)
>>>> +#define DRM_EDID_CLRMETRY_ADB_RGB     (1 << 4)
>>>> +#define DRM_EDID_CLRMETRY_BT2020_CYCC (1 << 5)
>>>> +#define DRM_EDID_CLRMETRY_BT2020_YCC  (1 << 6)
>>>> +#define DRM_EDID_CLRMETRY_BT2020_RGB  (1 << 7)
>>>> +#define DRM_EDID_CLRMETRY_DCI_P3      (1 << 15)
>>>> +
>>>>    /* ELD Header Block */
>>>>    #define DRM_ELD_HEADER_BLOCK_SIZE	4
>>>>    
>>>> -- 
>>>> 2.25.1
>>>>
>>>>
>>>>
>>>> _______________________________________________
>>>> dri-devel mailing list
>>>> dri-devel@lists.freedesktop.org
>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel


