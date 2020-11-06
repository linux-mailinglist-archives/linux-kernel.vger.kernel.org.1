Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8932A8C5B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 02:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732916AbgKFB6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 20:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730414AbgKFB6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 20:58:34 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2967AC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 17:58:34 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id z3so2877947pfz.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 17:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vVv3+3AmABS0sHIGexhab7WGK8cpnDXR7gJCvv/dFGw=;
        b=Gm63JYv5uosnltRq8lV9n/DpHMupwbUnoaLniJkjK1aN78eL1M3LsEQIqmTAJvh/31
         Tb0e/phDY4z+TbSB2e7/VpNfw2Sm3eViuO1s6CmqwZ+HNFg5euzn7kw+DHepOuLCjr2w
         R3P6StMrUkJWR7Mn9kBgozKTgcJtc7jIqKli4AuVIFmeogOVYrWiBn85j3GmWi8p5oC+
         ExfWYjSk4+kSe9r+XzhP3gc1OEtlTkKPfeJlOeyoWxZ+zbGLucw+7I4A/fD2Ti3lqgqB
         GYEIWXQQfLW3jxLMs+ZTIMMdsgYukqIepW55W/p0o22Xejus4nblLNElpaYcVsoDGOK/
         6YfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vVv3+3AmABS0sHIGexhab7WGK8cpnDXR7gJCvv/dFGw=;
        b=pI4ASmYo0XG0R3Ox08IBahq2Cj02WZH1IV9+ssLnWby7AhAIJGh8wmccVVFUrkt4+j
         fKyKCaQDeYkL3bOCfxVbmXFZDT07PewrObjTmZ625bnPbf60vDboyw1fpW2FsW0LerHt
         yDsbWjgKmezz8r3rDq7gik7wc9qedIjaKabHUVDDuhDR4RwGFLCaXV7OArZFFrvRqlJo
         ff6c1K0IxQkOfnnRor7IFiBTQyzW/saBBx+vMiAB7qJhU1HjW78qTxW+o8yZmijK3akw
         muQ28zQVGjV5rdyDFCQH/KhObntf7Uo9OwNzGgvH05Py4ra1ehYUVnjvXYruMGXb7xBl
         Fz6g==
X-Gm-Message-State: AOAM530aXlLUEDj/b4nfzolzEY+IcSi6guhlSxmh8CB/S0sDzopB2YPi
        yQ0lOiVTuFV50zXI6qBDG4sovg==
X-Google-Smtp-Source: ABdhPJybsVjKBTYfRBAs189nCX/YmKdU5B81hqinU/YE7NpDiSIXe1pYkeIOWlLdyV9iSq7YgmYAyw==
X-Received: by 2002:a62:8449:0:b029:18b:16d2:9ea0 with SMTP id k70-20020a6284490000b029018b16d29ea0mr5376552pfd.26.1604627913676;
        Thu, 05 Nov 2020 17:58:33 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([64.120.119.108])
        by smtp.gmail.com with ESMTPSA id r2sm2808830pji.55.2020.11.05.17.58.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Nov 2020 17:58:33 -0800 (PST)
Date:   Fri, 6 Nov 2020 09:58:28 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     =?iso-8859-1?Q?Andr=E9?= Przywara <andre.przywara@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Dave Martin <Dave.Martin@arm.com>, Al Grant <Al.Grant@arm.com>,
        Wei Li <liwei391@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 06/21] perf arm-spe: Refactor printing string to buffer
Message-ID: <20201106015828.GA13572@leoy-ThinkPad-X240s>
References: <20201030025724.19157-1-leo.yan@linaro.org>
 <20201030025724.19157-7-leo.yan@linaro.org>
 <91d5de6b-885e-d56d-0845-49b2dde6894c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91d5de6b-885e-d56d-0845-49b2dde6894c@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre, Dave,

On Mon, Nov 02, 2020 at 03:50:01PM +0000, André Przywara wrote:

[...]

> >  int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
> >  		     size_t buf_len)
> >  {
> > -	int ret, ns, el, idx = packet->index;
> > +	int ns, el, idx = packet->index;
> >  	unsigned long long payload = packet->payload;
> >  	const char *name = arm_spe_pkt_name(packet->type);
> > +	size_t blen = buf_len;
> > +	int err = 0;
> >  
> >  	switch (packet->type) {
> >  	case ARM_SPE_BAD:
> >  	case ARM_SPE_PAD:
> >  	case ARM_SPE_END:
> > -		return snprintf(buf, buf_len, "%s", name);
> > -	case ARM_SPE_EVENTS: {
> > -		size_t blen = buf_len;
> > -
> > -		ret = 0;
> > -		ret = snprintf(buf, buf_len, "EV");
> > -		buf += ret;
> > -		blen -= ret;
> > -		if (payload & 0x1) {
> > -			ret = snprintf(buf, buf_len, " EXCEPTION-GEN");
> > -			buf += ret;
> > -			blen -= ret;
> > -		}
> > -		if (payload & 0x2) {
> > -			ret = snprintf(buf, buf_len, " RETIRED");
> > -			buf += ret;
> > -			blen -= ret;
> > -		}
> > -		if (payload & 0x4) {
> > -			ret = snprintf(buf, buf_len, " L1D-ACCESS");
> > -			buf += ret;
> > -			blen -= ret;
> > -		}
> > -		if (payload & 0x8) {
> > -			ret = snprintf(buf, buf_len, " L1D-REFILL");
> > -			buf += ret;
> > -			blen -= ret;
> > -		}
> > -		if (payload & 0x10) {
> > -			ret = snprintf(buf, buf_len, " TLB-ACCESS");
> > -			buf += ret;
> > -			blen -= ret;
> > -		}
> > -		if (payload & 0x20) {
> > -			ret = snprintf(buf, buf_len, " TLB-REFILL");
> > -			buf += ret;
> > -			blen -= ret;
> > -		}
> > -		if (payload & 0x40) {
> > -			ret = snprintf(buf, buf_len, " NOT-TAKEN");
> > -			buf += ret;
> > -			blen -= ret;
> > -		}
> > -		if (payload & 0x80) {
> > -			ret = snprintf(buf, buf_len, " MISPRED");
> > -			buf += ret;
> > -			blen -= ret;
> > -		}
> > +		return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s", name);
> 
> Nothing critical, but in case you need to respin this series for
> whatever reason, you might want to use NULL for the first argument,
> since you return here and there is little point in setting err. Same for
> other cases where you return directly from an arm_spe_pkt_snprintf() call.
> But it doesn't hurt, so you could leave it as well, and it's more robust
> in case someone extends the code later.

Just remind, in the new patch set v7, I don't change to use NULL for
the first argument and still pass '&err', the main reason is to
consolidate with return value, which is heavily dependent on the 'err'
parameter of arm_spe_pkt_snprintf(); the brief form is as follow:

    switch (type) {
    ...
    case ARM_SPE_END:
        arm_spe_pkt_snprintf(&err, &buf, &blen, "%s", name);
        break;
    ...
    default:
        break;
    }

    handle the 'err';

    return err;

Please see the new introduced patch [1] so it can give more idea for
the changes.

Thanks,
Leo

[1] https://lore.kernel.org/patchwork/patch/1333881/
