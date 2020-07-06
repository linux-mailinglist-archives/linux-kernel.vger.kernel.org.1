Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C20215C7C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jul 2020 19:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbgGFRBM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 Jul 2020 13:01:12 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:60400 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729384AbgGFRBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 13:01:11 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jsUUL-0005pc-ND; Mon, 06 Jul 2020 11:01:05 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jsUUJ-0005CJ-SN; Mon, 06 Jul 2020 11:01:05 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Lee Jones <lee.jones@linaro.org>
Cc:     gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Yinghai Lu <yhlu.kernel@gmail.com>,
        Jason Wessel <jason.wessel@windriver.com>
References: <20200706133341.476881-1-lee.jones@linaro.org>
        <20200706133341.476881-26-lee.jones@linaro.org>
Date:   Mon, 06 Jul 2020 11:56:24 -0500
In-Reply-To: <20200706133341.476881-26-lee.jones@linaro.org> (Lee Jones's
        message of "Mon, 6 Jul 2020 14:33:34 +0100")
Message-ID: <87imf0mvk7.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1jsUUJ-0005CJ-SN;;;mid=<87imf0mvk7.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18khkDaZc3axoG/t6YW4c9dVrDhOpL38K0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=8.0 tests=ALL_TRUSTED,BAYES_20,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMNoVowels,XMSubLong,XM_B_Unicode autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.1922]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa08 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Lee Jones <lee.jones@linaro.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1393 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 12 (0.9%), b_tie_ro: 11 (0.8%), parse: 0.82
        (0.1%), extract_message_metadata: 24 (1.7%), get_uri_detail_list: 1.69
        (0.1%), tests_pri_-1000: 20 (1.4%), tests_pri_-950: 1.44 (0.1%),
        tests_pri_-900: 1.22 (0.1%), tests_pri_-90: 176 (12.7%), check_bayes:
        150 (10.8%), b_tokenize: 7 (0.5%), b_tok_get_all: 8 (0.6%),
        b_comp_prob: 2.1 (0.1%), b_tok_touch_all: 128 (9.2%), b_finish: 1.05
        (0.1%), tests_pri_0: 369 (26.5%), check_dkim_signature: 0.74 (0.1%),
        check_dkim_adsp: 2.4 (0.2%), poll_dns_idle: 762 (54.7%), tests_pri_10:
        2.2 (0.2%), tests_pri_500: 783 (56.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 25/32] usb: early: ehci-dbgp: Remove set but never checked variable 'ret'
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Jones <lee.jones@linaro.org> writes:

> 'ret' hasn't  been checked since the driver's inception in 2009.

Minor quibble the inception was in 5c05917e7fe3 ("x86: usb debug port
early console, v4") in July of 2008.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

> Fixes the following W=1 kernel build warning(s):
>
>  drivers/usb/early/ehci-dbgp.c: In function ‘early_dbgp_write’:
>  drivers/usb/early/ehci-dbgp.c:915:13: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
>  915 | int chunk, ret;
>  | ^~~
>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Yinghai Lu <yhlu.kernel@gmail.com>
> Cc: Jason Wessel <jason.wessel@windriver.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/usb/early/ehci-dbgp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/usb/early/ehci-dbgp.c b/drivers/usb/early/ehci-dbgp.c
> index 775cf70cfb3ed..b075dbfad730f 100644
> --- a/drivers/usb/early/ehci-dbgp.c
> +++ b/drivers/usb/early/ehci-dbgp.c
> @@ -912,7 +912,7 @@ int __init early_dbgp_init(char *s)
>  
>  static void early_dbgp_write(struct console *con, const char *str, u32 n)
>  {
> -	int chunk, ret;
> +	int chunk;
>  	char buf[DBGP_MAX_PACKET];
>  	int use_cr = 0;
>  	u32 cmd, ctrl;
> @@ -951,8 +951,8 @@ static void early_dbgp_write(struct console *con, const char *str, u32 n)
>  			buf[chunk] = *str;
>  		}
>  		if (chunk > 0) {
> -			ret = dbgp_bulk_write(USB_DEBUG_DEVNUM,
> -				      dbgp_endpoint_out, buf, chunk);
> +			dbgp_bulk_write(USB_DEBUG_DEVNUM,
> +					dbgp_endpoint_out, buf, chunk);
>  		}
>  	}
>  	if (unlikely(reset_run)) {
