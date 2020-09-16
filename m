Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C86826C90B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgIPTCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbgIPRss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:48:48 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56CAC0610D6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 04:17:21 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z18so1246505pfg.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 04:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xDTLOgcPdYGku1MSzrKX5CI5flgLveKVydp4S2eux5g=;
        b=SmeS+HkPV9XaWDqDLD2eX3RPgoc8o2L/sFcxCsAOrkqwsCJ9orIPoACFCb+1wryIVu
         RlXiKa8UmEMvx2DBYMMi3LJ6scwHP++hnCg8QEXAn/ltrAhEg7FdRU2yAd8rzA3b/nIQ
         v3gmZX7TeYNNJV8ptgLWOfbV/atLuHnpfe4PearOINjyaglYEBlTC6lB+RO5+iwPsVHP
         3ZDYKSYcl6wzTFeBPnE9ovZMwrDgH92adUGgwCa57jPWZYozFS2N1EnHR6La9EP+r97x
         XjiGB9iHPuRAzS5UoLjWmYv2fGSWJsgXtTX3rFtGjoC68uP+iPBy1FemaqAVj9GZw6pw
         NUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xDTLOgcPdYGku1MSzrKX5CI5flgLveKVydp4S2eux5g=;
        b=mpNEfnmTPVuEFC++AN1hFGVtI13aqghef+Yz92CIAIFlj/NnYAbfIkqgid2dcFi6TF
         vq2dsNtbriXBbrlajRmaRsInqXPrELu/fT3khbaP/iA1+aokXKFSK/qPVyswkJkMtGeY
         gr0xu+qdG0bKR+TnLEDT/qtIJaQT2AiM4InOuNhRAtI6sh2GMhM0EkU38eTyly73TBUm
         kxHbi4pSdRySoxJo+kJdPMLA1WchYsbVCxm7e3XCf6Do7BaruI2lwhQByN+M8qDz15fd
         Gd+F8MQzSYSTYxege155XOuWxRPaJdwu8HBFQggco3g3QYa53YV3DiyoKUdgAya8RpAP
         ALAQ==
X-Gm-Message-State: AOAM533Om6x4ct7eFyMpsDHxPlzS11QtV6SvVuGiBj2UvhpEx6+5at5V
        8uBEF8VtwtWaNGjwHSPD7gk=
X-Google-Smtp-Source: ABdhPJwmPmQ3+a3TJi+Aq8EqnUp5FlKCOcJorJoHj0auEqHOhyUCseUyjRaaS/73ViIhVyY94TocVw==
X-Received: by 2002:aa7:9093:0:b029:142:2501:396e with SMTP id i19-20020aa790930000b02901422501396emr6069023pfa.51.1600255040271;
        Wed, 16 Sep 2020 04:17:20 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
        by smtp.gmail.com with ESMTPSA id 84sm16656210pfw.14.2020.09.16.04.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 04:17:19 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date:   Wed, 16 Sep 2020 19:17:12 +0800
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     devel@driverdev.osuosl.org, Alex Elder <elder@kernel.org>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Mark Greer <mgreer@animalcreek.com>,
        "moderated list:GREYBUS SUBSYSTEM" <greybus-dev@lists.linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: greybus: fix warnings detected by sparse
Message-ID: <20200916111712.njkxmmypzcm6hp25@Rk>
References: <20200824025100.1068350-1-coiby.xu@gmail.com>
 <20200824094148.GY1793@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200824094148.GY1793@kadam>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 12:41:48PM +0300, Dan Carpenter wrote:
>On Mon, Aug 24, 2020 at 10:50:59AM +0800, Coiby Xu wrote:
>> This patch fix the following warnings from sparse,
>>
>> $ make C=2 drivers/staging/greybus/
>> drivers/staging/greybus/audio_codec.c:691:36: warning: incorrect type in initializer (different base types)
>> drivers/staging/greybus/audio_codec.c:691:36:    expected unsigned long long [usertype] formats
>> drivers/staging/greybus/audio_codec.c:691:36:    got restricted snd_pcm_format_t [usertype]
>> drivers/staging/greybus/audio_codec.c:701:36: warning: incorrect type in initializer (different base types)
>> drivers/staging/greybus/audio_codec.c:701:36:    expected unsigned long long [usertype] formats
>> drivers/staging/greybus/audio_codec.c:701:36:    got restricted snd_pcm_format_t [usertype]
>> drivers/staging/greybus/audio_module.c:222:25: warning: incorrect type in assignment (different base types)
>> drivers/staging/greybus/audio_module.c:222:25:    expected restricted __le16 [usertype] data_cport
>> drivers/staging/greybus/audio_module.c:222:25:    got unsigned short [usertype] intf_cport_id
>> drivers/staging/greybus/audio_topology.c:460:40: warning: restricted __le32 degrades to integer
>> drivers/staging/greybus/audio_topology.c:691:41: warning: incorrect type in assignment (different base types)
>> drivers/staging/greybus/audio_topology.c:691:41:    expected unsigned int access
>> drivers/staging/greybus/audio_topology.c:691:41:    got restricted __le32 [usertype] access
>> drivers/staging/greybus/audio_topology.c:746:44: warning: incorrect type in assignment (different base types)
>> drivers/staging/greybus/audio_topology.c:746:44:    expected unsigned int
>> drivers/staging/greybus/audio_topology.c:746:44:    got restricted __le32
>> drivers/staging/greybus/audio_topology.c:748:52: warning: incorrect type in assignment (different base types)
>> drivers/staging/greybus/audio_topology.c:748:52:    expected unsigned int
>> drivers/staging/greybus/audio_topology.c:748:52:    got restricted __le32
>> drivers/staging/greybus/audio_topology.c:802:42: warning: restricted __le32 degrades to integer
>> drivers/staging/greybus/audio_topology.c:805:50: warning: incorrect type in assignment (different base types)
>> drivers/staging/greybus/audio_topology.c:805:50:    expected restricted __le32
>> drivers/staging/greybus/audio_topology.c:805:50:    got unsigned int
>> drivers/staging/greybus/audio_topology.c:814:50: warning: restricted __le32 degrades to integer
>> drivers/staging/greybus/audio_topology.c:817:58: warning: incorrect type in assignment (different base types)
>> drivers/staging/greybus/audio_topology.c:817:58:    expected restricted __le32
>> drivers/staging/greybus/audio_topology.c:817:58:    got unsigned int
>> drivers/staging/greybus/audio_topology.c:889:25: warning: incorrect type in assignment (different base types)
>> drivers/staging/greybus/audio_topology.c:889:25:    expected unsigned int access
>> drivers/staging/greybus/audio_topology.c:889:25:    got restricted __le32 [usertype] access
>>
>> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
>> ---
>>  drivers/staging/greybus/audio_codec.c    |  4 ++--
>>  drivers/staging/greybus/audio_module.c   |  2 +-
>>  drivers/staging/greybus/audio_topology.c | 18 +++++++++---------
>>  3 files changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
>> index 74538f8c5fa4..494aa823e998 100644
>> --- a/drivers/staging/greybus/audio_codec.c
>> +++ b/drivers/staging/greybus/audio_codec.c
>> @@ -688,7 +688,7 @@ static struct snd_soc_dai_driver gbaudio_dai[] = {
>>  		.playback = {
>>  			.stream_name = "I2S 0 Playback",
>>  			.rates = SNDRV_PCM_RATE_48000,
>> -			.formats = SNDRV_PCM_FORMAT_S16_LE,
>> +			.formats = SNDRV_PCM_FMTBIT_S16_LE,
>>  			.rate_max = 48000,
>>  			.rate_min = 48000,
>>  			.channels_min = 1,
>> @@ -698,7 +698,7 @@ static struct snd_soc_dai_driver gbaudio_dai[] = {
>>  		.capture = {
>>  			.stream_name = "I2S 0 Capture",
>>  			.rates = SNDRV_PCM_RATE_48000,
>> -			.formats = SNDRV_PCM_FORMAT_S16_LE,
>> +			.formats = SNDRV_PCM_FMTBIT_S16_LE,
>>  			.rate_max = 48000,
>>  			.rate_min = 48000,
>>  			.channels_min = 1,
>
>These changes need to be explained better.  We're changing formats from
>2 to 1 << 2.
>
>When you're writing commit messages, please imagine me as the target
>audience.  I have a fairly decent understanding of the kernel and C, but
>I don't know very much about the sound subsystem.

(Sorry for the late reply! I didn't notice my email client failed to
delivered this email.)

Thank you for showing me SNDRV_PCM_FORMAT_S16_LE != SNDRV_PCM_FMTBIT_S16_LE.
I thought they only differ in type so no domain knowledge is needed.
>
>This code used to work, right?  How was it that changing a 2 to a 4
>makes it better?  It needs to be explained in the commit message.  This
>change probably needs to be split into a separate commit because it
>seems different from the rest of the patch.

After doing some homework on greybus, ALSA, PCM, etc., I think
SNDRV_PCM_FORMAT_S16_LE could be a mistake,

1. According to the struct definition,

struct snd_soc_dai_driver {
     ...
	/* DAI capabilities */
	struct snd_soc_pcm_stream capture;
	struct snd_soc_pcm_stream playback;
/* SoC PCM stream information */

struct snd_soc_pcm_stream {
	const char *stream_name;
	u64 formats;			/* SNDRV_PCM_FMTBIT_* */
     ...
};


We should use SNDRV_PCM_FMTBIT_* which is a bit mask while
SNDRV_PCM_FORMAT_* are sequential integers.

2. This "formats" member  represent PCM audio's resolution/sample Size,
Byte Order and Sign [1]. In terms of the values,
SNDRV_PCM_FORMAT_S16_LE == SNDRV_PCM_FMTBIT_S8.
Using 8 bits to represent the amplitude of the sound sample may lead to
low quality audio.

3. There is this commit e712bfca1ac1f63f622f87c2f33b57608f2a4d19
("ASoC: codecs: use SNDRV_PCM_FMTBIT_* for format bitmask"),

     snd_soc_pcm_stream.formats is a bitmask of SNDRV_PCM_FMTBIT_*,
     not of SNDRV_PCM_FORMAT_* (which are sequential integers),
     however some of ASoC CODEC drivers use these values instead.

which simply replaced SNDRV_PCM_FORMAT_S16_LE with SNDRV_PCM_FMTBIT_S16_LE.

>
>(Presumably the rest of the patch doesn't affect runtime on little
>endian systems.  This is the part which affects runtime so it is
>different from the rest).
>
>> diff --git a/drivers/staging/greybus/audio_module.c b/drivers/staging/greybus/audio_module.c
>> index 16f60256adb2..00848b84b022 100644
>> --- a/drivers/staging/greybus/audio_module.c
>> +++ b/drivers/staging/greybus/audio_module.c
>> @@ -219,7 +219,7 @@ static int gb_audio_add_data_connection(struct gbaudio_module_info *gbmodule,
>>
>>  	greybus_set_drvdata(bundle, gbmodule);
>>  	dai->id = 0;
>> -	dai->data_cport = connection->intf_cport_id;
>> +	dai->data_cport = cpu_to_le16(connection->intf_cport_id);
>>  	dai->connection = connection;
>>  	list_add(&dai->list, &gbmodule->data_list);
>>
>
>This is correct, but I think you should change the two places which
>print the data_cport to print the CPU endian value.
>
>   327          list_for_each_entry(dai, &gbmodule->data_list, list) {
>   328                  ret = gb_connection_enable(dai->connection);
>   329                  if (ret) {
>   330                          dev_err(dev,
>   331                                  "%d:Error while enabling %d:data connection\n",
>   332                                  ret, dai->data_cport);
>   333                          goto disable_data_connection;
>   334                  }
>   335          }
>
>   449          list_for_each_entry(dai, &gbmodule->data_list, list) {
>   450                  ret = gb_connection_enable(dai->connection);
>   451                  if (ret) {
>   452                          dev_err(dev,
>   453                                  "%d:Error while enabling %d:data connection\n",
>   454                                  ret, dai->data_cport);
>   455                          return ret;
>   456                  }
>   457          }
>
>Otherwise it's slightly confusing to mix the values.

Thank you for the suggestion! I'll fix it in next version.
>
>The rest of the patch seems fine to me.
>
>regards,
>dan carpenter
>
Thank you for reviewing this patch!

[1] https://wiki.multimedia.cx/index.php/PCM

--
Best regards,
Coiby
