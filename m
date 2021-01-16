Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 017942F8E22
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 18:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbhAPRFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 12:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbhAPQaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 11:30:09 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACE1C061360;
        Sat, 16 Jan 2021 08:18:53 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id k10so9928433wmi.3;
        Sat, 16 Jan 2021 08:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=d9hZ/TM5iFjRNEPcTQvwAm1Rf9sa0Vn8GHaFhrGDyS8=;
        b=Br7DlbQwVMZMdpQkS8OEUUubQLykxVinoU54O9T5LGgV73zKKYiSYp+EQEgEQHc3kd
         C3zHI+cIQVHmkewFEzkS6QcxKJefsVb1ES17Am1WyRxrmTs971Uo/whoH4+HjPE5eoiC
         3F6dBqeRALhbJTIWkIHFqeX2ItuHqy10KOrCF5B/L9RHSfNf67JXTLzYWloo81nVpHk4
         xpHQ6wf+ER8o+xHl0QwUjSYHkPu0Ms3BN8o6A6/3b5u1Zr4dQgHfl2ZL2rOkHGF/Wr0l
         /CFY6YQthHKjcTy+Nqzmnpo+RGkFnjH3P/OdxF/tjLCwOqgasGv3P8krGRqgRXOnIcg4
         wwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=d9hZ/TM5iFjRNEPcTQvwAm1Rf9sa0Vn8GHaFhrGDyS8=;
        b=q/aNHtpZ/6AK8P92Llmjf5hxSeOdu2hCFHkDBaj4oiTEIbwcPzRtoBpY4pfTLgV5gg
         om4+t3Afse1l0tCe1QnyoXxUA5ASaHr+MMxJHWXneNnzGBmu7o/nLc/p4hYgScOj1lr5
         52fhO6Ez9thxA6rfAma8zEvtQcAQJzcgHOyUU6D6/WPUagEU0fZbakeDoZBCmejUksPh
         F7zeZWjBLE68Yfxsqlw6X061JU7Ckv1n8xsztmDX2CuWbA5fC3bCexcWsMUXcgJMLOxI
         lgHwRT9ZRHcBBJ+FyZhHQna4N8dNWsAarq0SEAb9UO0vHotAIMaHEFm92zSk6ViOBOJ8
         WR/Q==
X-Gm-Message-State: AOAM531ZgbWInuKC4m+ymjYDU5gEjcAh2UXcR8pPwtA/4Bj8mGLuFLN7
        SXkeVfuNDILKrLxP6Q+MlQwglQ57++W5w2IDmVU=
X-Google-Smtp-Source: ABdhPJwfXUbrlF/7/i3HpOAjRWzSx6CID+NldJIDTrdbVDmdF/K2ezrDy2plL4pyJZXRpJrn9ujOZA==
X-Received: by 2002:a05:600c:2888:: with SMTP id g8mr13821246wmd.169.1610813932365;
        Sat, 16 Jan 2021 08:18:52 -0800 (PST)
Received: from [0.0.0.0] ([2a01:4f8:c17:e10a::1])
        by smtp.gmail.com with ESMTPSA id y6sm18721730wrp.6.2021.01.16.08.18.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Jan 2021 08:18:51 -0800 (PST)
Subject: Re: [PATCH v3 2/3] x86/platform/dell-privacy-wmi: add document for
 dell privacy driver
To:     "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        "Yuan, Perry" <Perry.Yuan@dell.com>,
        "oder_chiou@realtek.com" <oder_chiou@realtek.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
References: <20210112171755.14408-1-Perry_Yuan@Dell.com>
 <BY3PR19MB49137D1D7508190AF87655FEFAAA0@BY3PR19MB4913.namprd19.prod.outlook.com>
From:   Perry Yuan <perry979106@gmail.com>
Message-ID: <b58b36a6-e964-663b-cf76-c058ba6f36eb@gmail.com>
Date:   Sun, 17 Jan 2021 00:18:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <BY3PR19MB49137D1D7508190AF87655FEFAAA0@BY3PR19MB4913.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,
Thanks for your review.
On 2021/1/13 1:54, Limonciello, Mario wrote:
>> -----Original Message-----
>> From: Yuan, Perry <Perry_Yuan@Dell.com>
>> Sent: Tuesday, January 12, 2021 11:18
>> To: oder_chiou@realtek.com; perex@perex.cz; tiwai@suse.com;
>> hdegoede@redhat.com; mgross@linux.intel.com
>> Cc: lgirdwood@gmail.com; broonie@kernel.org; alsa-devel@alsa-project.org;
>> linux-kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org; Yuan,
>> Perry; Limonciello, Mario
>> Subject: [PATCH v3 2/3] x86/platform/dell-privacy-wmi: add document for dell
>> privacy driver
>>
>> From: Perry Yuan <perry_yuan@dell.com>
>>
>> Describe the Dell Privacy feature capabilities and devices
>> state class exposed by BIOS
>>
>> Signed-off-by: Perry Yuan <perry_yuan@dell.com>
>> ---
>>   .../testing/sysfs-platform-dell-privacy-wmi   | 31 +++++++++++++++++++
>>   1 file changed, 31 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/sysfs-platform-dell-privacy-wmi
> 
> I don't see a reason that the documentation needs to come in it's own commit.
> In v4, I would think this can collapse as part of:
> "Add support for Dell hardware privacy"
> 
Agreed. will merge this patch content to "Add support for Dell hardware 
privacy"
>>
>> diff --git a/Documentation/ABI/testing/sysfs-platform-dell-privacy-wmi
>> b/Documentation/ABI/testing/sysfs-platform-dell-privacy-wmi
>> new file mode 100644
>> index 000000000000..3dbc2d25b60e
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-platform-dell-privacy-wmi
>> @@ -0,0 +1,31 @@
>> +What:		/sys/bus/wmi/devices/6932965F-1671-4CEB-B988-
>> D3AB0A901919/devices_supported
>> +Date:		Jan 2021
>> +KernelVersion:	5.11
> I think this is 5.12 material now.
> Need to update this to approximate 5.12 date.
> 
>> +Contact:	"perry_yuan@dell.com>"
> 
> I think Dell addresses publicly use a period rather than an underscore, no?
> So shouldn't this be perry.yuan@dell.com? (Although I acknowledge it's an
> alias, I don't trust that I/T wouldn't remove that some day).
> 
changed using period for the mail address.
>> +Description:
>> +		Display which dell hardware level privacy devices are supported
>> +		“Dell Privacy” is a set of HW, FW, and SW features to enhance
>> +		Dell’s commitment to platform privacy for MIC, Camera, and
>> +		ePrivacy screens.
>> +		The supported privacy haredware privacy devices are:
> 
> You have a typo here.
will fix this in V4.
> 
>> +		 * 0x0 - None,
>> +		 * 0x1 - Microphone,
>> +		 * 0x2 - Camera,
>> +		 * 0x4 - ePrivacy Screen
> 
> So this is an bitmap encoded in the integer?  I think that needs to be mentioned
> in the documentation.
> 
Indeed it is a bitmap , will change this part as below in V4.

  What: 
/sys/bus/wmi/devices/6932965F-1671-4CEB-B988-D3AB0A901919/devices_supported
  Date:          Jan 2021
-KernelVersion: 5.11
-Contact:       "perry_yuan@dell.com>"
+KernelVersion: 5.12
+Contact:       "perry.yuan@dell.com>"
  Description:
                 Display which dell hardware level privacy devices are 
supported
                 “Dell Privacy” is a set of HW, FW, and SW features to 
enhance
                 Dell’s commitment to platform privacy for MIC, Camera, and
                 ePrivacy screens.
-               The supported privacy haredware privacy devices are:
-                * 0x0 - None,
-                * 0x1 - Microphone,
-                * 0x2 - Camera,
-                * 0x4 - ePrivacy Screen
+               The supported hardware privacy devices are:
+               - 0 = Not Supported
+               - 1 = Supported
+               - Bit0 -> Microphone
+               - Bit1 -> Camera
+               - Bit2 -> ePrivacy Screen

>> +
>> +What:		/sys/bus/wmi/devices/6932965F-1671-4CEB-B988-
>> D3AB0A901919/current_state
>> +Date:		Jan 2021
>> +KernelVersion:	5.11
>> +Contact:	"perry_yuan@dell.com>"
>> +Description:
>> +		Allow user space to check current dell privacy device state.
>> +		Describes the Device State class exposed by BIOS which can be
>> +		consumed by various applications interested in knowing the Privacy
>> +		feature capabilities
>> +		There are three Bits for available states:
>> +		    * 0 -> Off
>> +		    * 1 -> On
>> +		    * Bit0 -> Microphone
>> +		    * Bit1 -> Camera
>> +		    * Bit2 -> ePrivacyScreen
>> +
>> --
>> 2.25.1
> 

