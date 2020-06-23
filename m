Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C5C204B4D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 09:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731246AbgFWHhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 03:37:12 -0400
Received: from mout.web.de ([212.227.15.4]:54345 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730977AbgFWHhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 03:37:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592897786;
        bh=pznEQ5bG/VouxoDw6QUID9gY5sIxURTnCH2b3j82ma4=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=Mv9PjwIjPBiTpetcOi7lLK0vv7cws5ZAWdUs+fp1lDJZtVhbtvNrUphdC/l0oWT4G
         M+H1Se0wR884SEvceoNIaXemo4h6voryyYoKxRv7VrUQWHah9fQXQdBpA+r4nY9B8U
         wuUPrSh25Ze13TEb3/BT46Gst0+eXLN+2tEj8QTY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.105.198]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MWQyl-1jLLCz1eix-00XseN; Tue, 23
 Jun 2020 09:36:26 +0200
To:     Shengjiu Wang <shengjiu.wang@nxp.com>, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@kernel.org>,
        Xiubo Li <Xiubo.Lee@gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: fsl_mqs: Don't check clock is NULL before
 calling clk API
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <39ac8f24-3148-2a3d-3f8d-91567b3c4c9e@web.de>
Date:   Tue, 23 Jun 2020 09:36:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:jCcPfr4SWsukrU2vTvHLIEkC3KqCB7tdu9JauATybzpZ1F2eud4
 iTH4MULNuZbrv+OFDx5oYLrgDMYfgfcnLOuFXBvriqXrwAq2ASp8SMODBjtiVvCwiaMkzpw
 WHC1HNSVZ7KPRZIma/oTwN5YTMjcb+ziGjyxiTmnGUc6PYXilkNEddPnAN3wtLaw8EaVAVH
 JXwq5RUacXHN74/hJ3ASw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:aBQ9A/3VNt0=:XMmfRpbLY2VOnE2DQ5F8WS
 eU0Z+S2bvuYctObeNE+RRkTFqKh91xQZfsvg0549ncdqVhnojTxHoUNQVFsGzxkia50SGu1e3
 dYhCX5A4ifn/xRFdij2POrk9YmleCoIf/KR5NFhA1AO6Nwn5J7QOPqH1PzMuwTRGQZdawFnDU
 W16Vs1Xz6O/nMoeQzBJHR0pbdebn3umPqQQ4MIdlH3ok/9IozUlpAxd6XTtR27QZKatkeHuE1
 xxJ/A02iBMNbZ7qPnRur6wOuP55CZImYQM/X44ZSpEdL0dcfYO//rmdHItR/EuaiFIjg1J0Hs
 vToBVsfiKxFl0WLJgQIVtRNS3xbQSpU5EWdFH8tkWb6a5y5Wkf940LeSVcvthfmfyaXXQuC3X
 JVR1N7JWuURCSvKhJSiAA7Obv3Tz3Tq0KDBsnxbf14KRRofEsTS3PcRmW88TRkD2WYXCMq5M+
 t0kexCte5TJ33jlnwazu3RDlhM6DH9GbUncQp/jm7zzqmSDbwRO4hzIfwIJGADl22eOL3ZZSx
 RnDU+eMCEZz0bJNqZ/CBMpp+asEMuhYzEpq9ouOUd3eJaZsiciqn//lOO9nQBtkQbsxN8UJxW
 hlWOZweFa1iI3ITG9uJijFcZ23mpZM85qDas9LMWl+Lw1lACkoMv7bP5sOCRJa0w8CYVtoY81
 W6XYuK+4EolZFaQ3b8fW5DKCtEw3tEYoVuPdVQfo7a3waal4X1GwKIJbpX53uYDdlTWteHsSB
 LxGnVfvUp6gf+n+hhEWJqhmX+RGWAjJnEC6uJWpEYQ7ZkiMA79WO6HM5efP4v3m2PEYTVnJto
 O567BfAEwlnOP8mIlp0ArpJSY4u6RdKVv9X7P2iAhkFdQ21zyZ0ZVHVqJ5yNxaYHgxILXuTgZ
 h09h8+egDeqGwUFJ4KKo3UXfg9bJe5Yjh1wu83jfT38u1Ahcl37g3O7UCA11xJO2zuRsouHGG
 esZKKveXaurIXgbGHElOzq1pnepumbWEQLV9MYEP3A+HbosgQPY9OYKnpzZ8SxF8/5EgN1ItO
 ciORZAVAHnXBtwxoIrMsgSbN6NhHgKXJBOrPa0G75U7s9xLhsDPt0Colw1r1DLEtYzvEUbD1a
 L2d3D+HiuSZTSIuDRBBhd4IfCqfBqQfby+cdnUOKZi1mYUoAD7Bm/yXIws+lCBYY7XcfYqFq4
 aLoeIvU8pZMCWXn5TXs1wgg8Ax+/g++1PaBcLmSaHwBPyNkir1wDe++AmWgYFxcYVFGOl3CRv
 mJSoyvohOTMnIvZ0G
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In-Reply-To: <cover.1592888591.git.shengjiu.wang@nxp.com>

I guess that it should be sufficient to specify such a field once
for the header information.


> Because clk_prepare_enable and clk_disable_unprepare should
> check input clock parameter is NULL or not internally,

I find this change description unclear.


> then we don't need to check them before calling the function.

Please use an imperative wording for the commit message.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=dd0d718152e4c65b173070d48ea9dfc06894c3e5#n151

Regards,
Markus
