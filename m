Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1524D29E998
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 11:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbgJ2KwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 06:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbgJ2KwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:52:08 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982CCC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 03:52:08 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id r10so2005834pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 03:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=AVLNMELJuB6RwHIVg0oVGqRV/F9zrDVSxIfMIXKmbRU=;
        b=S3sxFCLwkFuYWx5YwiM9BxiJ2xTMVR/H1h9yyUfzzLvk2ytUJHB7+Po8aobYWAWEUf
         jm4Gubf8VImIq5h8jblf1D3Wgj/oGsO215EqwPxUFw2YN7f+uPcNCPiL0DBHXFFr/TLa
         c8t2G8OROlCeZhDDB7HEYn6nCX3Wvm5GOQo32ENbj/RCgUWb2GTqpP/2q1U+oM4QZT6r
         PX0GMjtYfyhpehgRh98Q02Lm8Cd05ojL8V1YwHU1QVNzivGd9/yceb5FtXhNUAux99Ff
         TSCn0fOCVwTFR+C0C4euVL4EBg7AwvJADabcy2qcEs6sn5NZQhiBcX0kJWgyU4Lr+vNS
         NaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AVLNMELJuB6RwHIVg0oVGqRV/F9zrDVSxIfMIXKmbRU=;
        b=F6srazbVDjLAkXxzhB7wJHgwQiJzn/JFZAxhMVRz87nTzH350+cjva9jHCeAUxne+Q
         SARsE3DwCzVod3d6JHF2fjt0mLq/15ZcnbPEVMlgRKsvg0vqoEnIT/piAtdKeJNeMHqr
         M3PWVSgPa5WfTwVfrS6Pk8ADf7vDpG2KPYtJ1wO4x3Q22fTplH+ARIzP186IP6qTzUaY
         X3rmHJz/j5dUXoTpWnro5CkGsfezZMbb/wXbgUR2W0n727GMTRLrRKxJVosTBP05ZAG2
         TIWxYj00hpRgWbdneBx6LW5PYunvLds20a8aVwbTzOOrrpvv9ZpA/SSA/OiWKqJDtMjh
         eJdw==
X-Gm-Message-State: AOAM533UlOmXR4+jO1mTDrezAhbV6fPrSCxUkx614kv72TTAILVxSsoi
        CRkDtxyWnB/hRu5sn78Lfl+JsA==
X-Google-Smtp-Source: ABdhPJxgRY8sgUI0aW+I50/L0IwmmXVUmDhKY9cv7RkPRH+fiid34hdaJCZPVuSM8dFLkvl9z4aFqg==
X-Received: by 2002:a63:e657:: with SMTP id p23mr3423117pgj.116.1603968728059;
        Thu, 29 Oct 2020 03:52:08 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([103.141.182.112])
        by smtp.gmail.com with ESMTPSA id n64sm2516350pfn.134.2020.10.29.03.52.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 03:52:07 -0700 (PDT)
Date:   Thu, 29 Oct 2020 18:51:59 +0800
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
Message-ID: <20201029105159.GG16862@leoy-ThinkPad-X240s>
References: <20201029071927.9308-1-leo.yan@linaro.org>
 <20201029071927.9308-7-leo.yan@linaro.org>
 <cbb23f8e-b534-fffa-4dfe-a496fd3f6bef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cbb23f8e-b534-fffa-4dfe-a496fd3f6bef@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,

On Thu, Oct 29, 2020 at 10:23:39AM +0000, André Przywara wrote:

[...]

> > +static int arm_spe_pkt_snprintf(int *err, char **buf_p, size_t *blen,
> > +				const char *fmt, ...)
> > +{
> > +	va_list ap;
> > +	int ret;
> > +
> > +	va_start(ap, fmt);
> > +	ret = vsnprintf(*buf_p, *blen, fmt, ap);
> > +	va_end(ap);
> > +
> > +	if (ret < 0) {
> > +		if (err && !*err)
> > +			*err = ret;
> > +	} else {
> > +		*buf_p += ret;
> > +		*blen -= ret;
> > +	}
> > +
> > +	return ret;
> > +}
> 
> So this now implements the old behaviour of ignoring previous errors, in
> all cases, since we don't check for errors and bail out in the callers.
> 
> If you simply check for validity of err and for it being 0 before
> proceeding with the va_start() above, this should be fixed.

I think you are suggesting below code, could you take a look for it
before I proceed to respin new patch?

static int arm_spe_pkt_snprintf(int *err, char **buf_p, size_t *blen,
				const char *fmt, ...)
{
	va_list ap;
	int ret;

        /* Bail out if any error occurred */
        if (err && *err)
                return *err;

	va_start(ap, fmt);
	ret = vsnprintf(*buf_p, *blen, fmt, ap);
	va_end(ap);

	if (ret < 0) {
		if (err && !*err)
			*err = ret;
	} else {
		*buf_p += ret;
		*blen -= ret;
	}

	return ret;
}

Thanks,
Leo
