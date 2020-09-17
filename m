Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28BF26E78F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 23:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgIQVqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 17:46:31 -0400
Received: from mga14.intel.com ([192.55.52.115]:65310 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbgIQVqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 17:46:31 -0400
IronPort-SDR: axf+HoJ90SfdUDYT1oOxFUDQ685O/BR61kqcGfrW5LFwCvuUucEGilAmwHGxEG+iWV5OghJ1Wp
 OcgEnYKi05mQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="159105813"
X-IronPort-AV: E=Sophos;i="5.77,272,1596524400"; 
   d="scan'208";a="159105813"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 14:46:29 -0700
IronPort-SDR: 4v506Jv4WNG8inJA6c0dcYElPBXLhmBjERs77eC/TvL6SfRnAMW2nK5nbrBfR3DgUSYstFPc5M
 DckGfjp+fSsA==
X-IronPort-AV: E=Sophos;i="5.77,272,1596524400"; 
   d="scan'208";a="344508817"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 14:46:28 -0700
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 3FC1A6369;
        Thu, 17 Sep 2020 14:46:28 -0700 (PDT)
Date:   Thu, 17 Sep 2020 14:46:28 -0700
From:   mark gross <mgross@linux.intel.com>
To:     trix@redhat.com
Cc:     ibm-acpi@hmh.eng.br, dvhart@infradead.org, andy@infradead.org,
        natechancellor@gmail.com, ndesaulniers@google.com,
        len.brown@intel.com, ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: initialize tp_nvram_state
 variable
Message-ID: <20200917214628.GC29136@mtg-dev.jf.intel.com>
Reply-To: mgross@linux.intel.com
References: <20200913190203.22238-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200913190203.22238-1-trix@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: mark gross <mgross@linux.intel.com>

--mark


On Sun, Sep 13, 2020 at 12:02:03PM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> clang static analysis flags this represenative problem
> thinkpad_acpi.c:2523:7: warning: Branch condition evaluates
>   to a garbage value
>                 if (!oldn->mute ||
>                     ^~~~~~~~~~~
> 
> In hotkey_kthread() mute is conditionally set by hotkey_read_nvram()
> but unconditionally checked by hotkey_compare_and_issue_event().
> So the tp_nvram_state variable s[2] needs to be initialized.
> 
> Fixes: 01e88f25985d ("ACPI: thinkpad-acpi: add CMOS NVRAM polling for hot keys (v9)")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/platform/x86/thinkpad_acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 47925c319d7b..24da8b6872f2 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -2573,7 +2573,7 @@ static void hotkey_compare_and_issue_event(struct tp_nvram_state *oldn,
>   */
>  static int hotkey_kthread(void *data)
>  {
> -	struct tp_nvram_state s[2];
> +	struct tp_nvram_state s[2] = { 0 };
>  	u32 poll_mask, event_mask;
>  	unsigned int si, so;
>  	unsigned long t;
> -- 
> 2.18.1
> 
