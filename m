Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D812A6B6F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 18:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731240AbgKDRK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 12:10:28 -0500
Received: from mga06.intel.com ([134.134.136.31]:4192 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731090AbgKDRK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 12:10:27 -0500
IronPort-SDR: 2XE+wsBvwbOz50QR8WpcRYoLYIC1AI2oAJnF2zHEBuPmOZNXkXf/MaOmyU7MqzHh7RwjgWeTl2
 SkthUNKr+s+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9795"; a="230881964"
X-IronPort-AV: E=Sophos;i="5.77,451,1596524400"; 
   d="scan'208";a="230881964"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 09:10:24 -0800
IronPort-SDR: jwiQpi1ObuYxAb+wBA2q+guATDxmobmCi2MBRmYN9SluTeekXy/BIfKQK4FPwLWW0NBSErmeW5
 zdAVX6W3BWpA==
X-IronPort-AV: E=Sophos;i="5.77,451,1596524400"; 
   d="scan'208";a="538988928"
Received: from msridhar-mobl1.amr.corp.intel.com (HELO [10.254.96.252]) ([10.254.96.252])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 09:10:23 -0800
Subject: Re: sound/soc/intel/skylake/skl-topology.c:3642:1: warning: the frame
 size of 1256 bytes is larger than 1024 bytes
To:     kernel test robot <lkp@intel.com>,
        Mateusz Gorski <mateusz.gorski@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>
References: <202011041516.a6zglw24-lkp@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <471bf009-0930-4a06-3f74-9f1414db56ef@linux.intel.com>
Date:   Wed, 4 Nov 2020 11:10:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202011041516.a6zglw24-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>     sound/soc/intel/skylake/skl-topology.c: In function 'skl_tplg_complete':
>>> sound/soc/intel/skylake/skl-topology.c:3642:1: warning: the frame size of 1256 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>      3642 | }
>           | ^
> 
> vim +3642 sound/soc/intel/skylake/skl-topology.c
> 
>    3612	
>    3613	static void skl_tplg_complete(struct snd_soc_component *component)
>    3614	{
>    3615		struct snd_soc_dobj *dobj;
>    3616		struct snd_soc_acpi_mach *mach =
>    3617			dev_get_platdata(component->card->dev);
>    3618		int i;
>    3619	
>    3620		list_for_each_entry(dobj, &component->dobj_list, list) {
>    3621			struct snd_kcontrol *kcontrol = dobj->control.kcontrol;
>    3622			struct soc_enum *se =
>    3623				(struct soc_enum *)kcontrol->private_value;
>    3624			char **texts = dobj->control.dtexts;
>    3625			char chan_text[4];
>    3626	
>    3627			if (dobj->type != SND_SOC_DOBJ_ENUM ||
>    3628			    dobj->control.kcontrol->put !=
>    3629			    skl_tplg_multi_config_set_dmic)
>    3630				continue;
>    3631			sprintf(chan_text, "c%d", mach->mach_params.dmic_num);
>    3632	
>    3633			for (i = 0; i < se->items; i++) {
>    3634				struct snd_ctl_elem_value val;

that structure seems to be the root-cause of this warning. This can take 
512+128 bytes and probably does not belong on the stack.

struct snd_ctl_elem_value {
	struct snd_ctl_elem_id id;	/* W: element ID */
	unsigned int indirect: 1;	/* W: indirect access - obsoleted */
	union {
		union {
			long value[128];
			long *value_ptr;	/* obsoleted */
		} integer;
		union {
			long long value[64];
			long long *value_ptr;	/* obsoleted */
		} integer64;
		union {
			unsigned int item[128];
			unsigned int *item_ptr;	/* obsoleted */
		} enumerated;
		union {
			unsigned char data[512];
			unsigned char *data_ptr;	/* obsoleted */
		} bytes;
		struct snd_aes_iec958 iec958;
	} value;		/* RO */
	unsigned char reserved[128];
};

>    3635	
>    3636				if (strstr(texts[i], chan_text)) {
>    3637					val.value.enumerated.item[0] = i;
>    3638					kcontrol->put(kcontrol, &val);
>    3639				}
>    3640			}
>    3641		}
>> 3642	}

