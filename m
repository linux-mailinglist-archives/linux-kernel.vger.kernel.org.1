Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7FB929E9FF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 12:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgJ2LGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 07:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbgJ2LGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 07:06:15 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6DCC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 04:06:14 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id o129so2057728pfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 04:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=AjypJEOlHsBxT2MXyKdhhIhqcKDZCftJZ37NZpTJExY=;
        b=EphyJo2KzSt2N6h/sjIrO+h4VKDgDqcfHRCCKb2I4IZ+1jpajOeVj0tFz78kPJKO+L
         d0yClkIB6+Dn17GYpFYLiOVrJIP/CgY2ibyzB+tHhkE+y8+mH7ArMe7khNfKLglhmnRD
         VBteZaGip3EoJMGg1o1Rn31a/tUBE7A0FCN+0CVoimPiV7eQHMs8zpxIzWVXuGEWjS70
         ZLYNVKxv3SGZTYrRh/vnFH8nFTe4DhbTxkGFvuiiMLyo1jBoAEH0djhTqsFykb+F/GRT
         veyKEDtpMqQ3NKMBqeurZNK/sAISwobNycUgCwjaBBujIwPUHzyn4OBjBu0udl3c0U2e
         HbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AjypJEOlHsBxT2MXyKdhhIhqcKDZCftJZ37NZpTJExY=;
        b=rZUxS7lWth/HUORqLhOgbcC2MGmLpoS4mp6ilXUUdvmDUWhwRfQl4PDEXBaR7UFGTY
         r9g6TJ5jWYqr3/z+cdLk+go0XVhyagj5je/AZ5tV6A58f3SzSs+/breNeKL7pSvXL8dj
         OtzUt/dx/qfgc4qdhM1BCw83SinaIQnWwfpZTnzHZ/7hrOCgnEIWJsLPVrTbHIG7iNVo
         E7klQXjJzFzN7/s7zBmzYNhtAyFLsCK7uHS2fjNwySJap48xtn2Tu2TSyEUhba/ADnzB
         YEz5x2zG8j/JFjjdjRfsuvpxRmHmWJjjtXL8F7eJIEW1+j3PKA/QwDsSNShGFKsj359/
         s+1g==
X-Gm-Message-State: AOAM53070rBN9LC2cn89ikX9m/vd6xQxzPFeJ3HxduYzWI4vYY0CHyOX
        Y3jshOtP9ryQFSXvn66sQU4+IQ==
X-Google-Smtp-Source: ABdhPJzD8q3gApKC8ryynmFbUbGBjRUWuI4M9lU3NSGVvgD6/TpTdnTyvIMFTTikdTyfIJM8ekgtkg==
X-Received: by 2002:a17:90a:a898:: with SMTP id h24mr3826758pjq.179.1603969573827;
        Thu, 29 Oct 2020 04:06:13 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([103.141.182.112])
        by smtp.gmail.com with ESMTPSA id h26sm138984pfq.139.2020.10.29.04.06.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 04:06:13 -0700 (PDT)
Date:   Thu, 29 Oct 2020 19:06:05 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     =?iso-8859-1?Q?Andr=E9?= Przywara <andre.przywara@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Wei Li <liwei391@huawei.com>,
        James Clark <james.clark@arm.com>, Al Grant <Al.Grant@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 06/21] perf arm-spe: Refactor printing string to buffer
Message-ID: <20201029110605.GI16862@leoy-ThinkPad-X240s>
References: <20201029071927.9308-1-leo.yan@linaro.org>
 <20201029071927.9308-7-leo.yan@linaro.org>
 <cbb23f8e-b534-fffa-4dfe-a496fd3f6bef@arm.com>
 <20201029105159.GG16862@leoy-ThinkPad-X240s>
 <f6a3df74-edc5-6a0e-dc36-7c1efaf55ffc@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6a3df74-edc5-6a0e-dc36-7c1efaf55ffc@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 10:54:37AM +0000, André Przywara wrote:
> On 29/10/2020 10:51, Leo Yan wrote:
> > Hi Andre,
> > 
> > On Thu, Oct 29, 2020 at 10:23:39AM +0000, Andrï¿½ Przywara wrote:
> > 
> > [...]
> > 
> >>> +static int arm_spe_pkt_snprintf(int *err, char **buf_p, size_t *blen,
> >>> +				const char *fmt, ...)
> >>> +{
> >>> +	va_list ap;
> >>> +	int ret;
> >>> +
> >>> +	va_start(ap, fmt);
> >>> +	ret = vsnprintf(*buf_p, *blen, fmt, ap);
> >>> +	va_end(ap);
> >>> +
> >>> +	if (ret < 0) {
> >>> +		if (err && !*err)
> >>> +			*err = ret;
> >>> +	} else {
> >>> +		*buf_p += ret;
> >>> +		*blen -= ret;
> >>> +	}
> >>> +
> >>> +	return ret;
> >>> +}
> >>
> >> So this now implements the old behaviour of ignoring previous errors, in
> >> all cases, since we don't check for errors and bail out in the callers.
> >>
> >> If you simply check for validity of err and for it being 0 before
> >> proceeding with the va_start() above, this should be fixed.
> > 
> > I think you are suggesting below code, could you take a look for it
> > before I proceed to respin new patch?>
> > static int arm_spe_pkt_snprintf(int *err, char **buf_p, size_t *blen,
> > 				const char *fmt, ...)
> > {
> > 	va_list ap;
> > 	int ret;
> > 
> >         /* Bail out if any error occurred */
> >         if (err && *err)
> >                 return *err;
> > 
> > 	va_start(ap, fmt);
> > 	ret = vsnprintf(*buf_p, *blen, fmt, ap);
> > 	va_end(ap);
> > 
> > 	if (ret < 0) {
> > 		if (err && !*err)
> > 			*err = ret;
> > 	} else {
> > 		*buf_p += ret;
> > 		*blen -= ret;
> > 	}
> > 
> > 	return ret;
> > }
> 
> Yes, this is what I had in mind.

Thanks for confirmation, Andre.

Leo
