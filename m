Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6924629DB87
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389387AbgJ2AAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:00:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59842 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389366AbgJ2AAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:00:06 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kXkMS-0005Pl-G9; Wed, 28 Oct 2020 12:15:28 +0000
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org
From:   Colin Ian King <colin.king@canonical.com>
Subject: re: ASoC: qcom: sm8250: add sound card qrb5165-rb5 support
Message-ID: <f441bb6c-12eb-a565-c34d-950da2b045d7@canonical.com>
Date:   Wed, 28 Oct 2020 12:15:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Static analysis on linux-next with Coverity had detected a potential
array out-of-bounds write issue in the following commit:

commit aa2e2785545aab21b6cb2e23f111ae0751cbcca7
Author: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date:   Mon Oct 26 17:09:47 2020 +0000

    ASoC: qcom: sm8250: add sound card qrb5165-rb5 support

The analysis is as follows:

139 static int sm8250_snd_hw_free(struct snd_pcm_substream *substream)
140 {
141        struct snd_soc_pcm_runtime *rtd = substream->private_data;
142        struct sm8250_snd_data *data =
snd_soc_card_get_drvdata(rtd->card);
143        struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
144        struct sdw_stream_runtime *sruntime =
data->sruntime[cpu_dai->id];
145

   1. Switch case value 105.

146        switch (cpu_dai->id) {

   2. equality_cond: Jumping to case 105.

147        case WSA_CODEC_DMA_RX_0:
148        case WSA_CODEC_DMA_RX_1:

   Out-of-bounds write (OVERRUN)
   3. Condition sruntime, taking true branch.
   4. Condition data->stream_prepared[cpu_dai->id], taking true branch.

149                if (sruntime && data->stream_prepared[cpu_dai->id]) {
150                        sdw_disable_stream(sruntime);
151                        sdw_deprepare_stream(sruntime);

   Out-of-bounds write (OVERRUN)
   5. overrun-local: Overrunning array data->stream_prepared of 16 bytes
at byte offset 105 using index cpu_dai->id (which evaluates to 105).

152                        data->stream_prepared[cpu_dai->id] = false;
153                }
154                break;
155        default:
156                break;
157        }
158
159        return 0;
160 }

So cpu_dia->id is 105 in this case statement, and yet
data->steam_prepared is an array of 16 elements, so this looks suspect.

Colin
