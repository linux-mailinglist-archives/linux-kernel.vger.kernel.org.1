Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97ED22AFE26
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 06:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbgKLFea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 00:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbgKLCVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 21:21:00 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9293FC061A47
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 18:20:07 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id g7so3107485pfc.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 18:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=n9mkhOK1cTjJziFp+RemHGgP/Offi+hIAS6UwhyqMZM=;
        b=RQEt0VxvDtrDuFopAECyXYCB6K4xI+lVQGmsiMTYYHKUWcCRFz9Q5DN3u08SE3pUgd
         tOltkdRG9dpP9RZw0R8f7JdLkAACQwZm9wOJGGa0+3Jyv/9Jm/3c2dSekC96pqgSGNGp
         X5acYnXYZttHEVCkHEd+J2pJ2l7ecXqcr7U9Rz7TehB6ib8FOqF+tIB+ozRjOmTTi0Jh
         gTAwhjWRqU/5WMqfsvC+/ojqcU+syPzRDhTaYifq33+Wiu676yUEw7kP0ZiGkAngFvE3
         NVj3yvP9XObFLIEwT94kqyhEYjh1OVe1tUCxtbxVB9uzftVvkKyFuTh9Z39ZI7PghPAV
         dQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=n9mkhOK1cTjJziFp+RemHGgP/Offi+hIAS6UwhyqMZM=;
        b=gKOZ7lKq+C/TpfjxB9j8ooixjTDE7LObJyfjx6MOW/iRwTx15MscZe+9Rr7h9Y4gGe
         zpQ0uqXv+fkZtsmpK1w5S7bbL6xSNcv+9B3NPTiKrsgvMDmWHvZ2I6aNN79RvGBab9dp
         AutUJ79bgNZ6KjlPgPanXvuUX3FYKj1J7EMai4QcMbjTiWGQfpi2pDE0g0EIH9v3Nsph
         c6QSmL8se9wrzCALosB9m32c6/LVv4l7szrkFp6pYp9uXEHBX7W7nRDdjPQEF2JDDwRa
         OUpQazLGFNtiQT7BxZzWWR2vjaKhG/0+55vLG/e6vTfTfBTS8MWTbO6GmhXu+ejQQCE+
         w6jg==
X-Gm-Message-State: AOAM5311JpvbTcO+XYquqX/MK/ujw3XGzJ33c0/+JxO6XoaP8/1r2ONF
        MEOcvMk0/Ie2bHDDUcygbgg+vQ==
X-Google-Smtp-Source: ABdhPJx3xyWGpT39Ext85b7DnT239h7dXhP8tTzutBNGtHtiWQUZEKvRp/VX8wM2A0MhAxhXnDt8Cg==
X-Received: by 2002:a62:248:0:b029:18c:992f:e407 with SMTP id 69-20020a6202480000b029018c992fe407mr3589902pfc.37.1605147607035;
        Wed, 11 Nov 2020 18:20:07 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([103.127.239.100])
        by smtp.gmail.com with ESMTPSA id m66sm4230592pfm.54.2020.11.11.18.20.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Nov 2020 18:20:06 -0800 (PST)
Date:   Thu, 12 Nov 2020 10:20:00 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Andre Przywara <Andre.Przywara@arm.com>,
        James Clark <James.Clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Al Grant <Al.Grant@arm.com>, Wei Li <liwei391@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 06/22] perf arm-spe: Refactor printing string to buffer
Message-ID: <20201112022000.GB5852@leoy-ThinkPad-X240s>
References: <20201111071149.815-1-leo.yan@linaro.org>
 <20201111071149.815-7-leo.yan@linaro.org>
 <20201111153555.GG355344@kernel.org>
 <a1ca3412-3815-e2a8-0334-f3059802df6a@arm.com>
 <20201111173922.GA380127@kernel.org>
 <20201111175827.GR6882@arm.com>
 <20201111180127.GD380127@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201111180127.GD380127@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 03:01:27PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Nov 11, 2020 at 05:58:27PM +0000, Dave Martin escreveu:
> > 
> > On Wed, Nov 11, 2020 at 05:39:22PM +0000, Arnaldo Carvalho de Melo wrote:
> > > Em Wed, Nov 11, 2020 at 03:45:23PM +0000, Andr� Przywara escreveu:
> > > > On 11/11/2020 15:35, Arnaldo Carvalho de Melo wrote:
> > > > > Isn't this 'ret +=' ? Otherwise if any of these arm_spe_pkt_snprintf()
> > > > > calls are made the previous 'ret' value is simply discarded. Can you
> > > > > clarify this?
> 
> > > > ret is the same as err. If err is negative (from previous calls), we
> > > > return that straight away, so it does nothing but propagating the error.
> 
> > > Usually the return of a snprintf is used to account for buffer space, ok
> > > I'll have to read it, which I shouldn't as snprintf has a well defined
> > > meaning...
> 
> > > Ok, now that I look at it, I realize it is not a snprintf() routine, but
> > > something with different semantics, that will look at a pointer to an
> > > integer and then do nothing if it comes with some error, etc, confusing
> > > :-/
> 
> > Would you be happier if the function were renamed?
> 
> > Originally we were aiming for snprintf() semantics, but this still
> > spawns a lot of boilerplate code and encourages mistakes in the local
> > caller here -- hence the current sticky error approach.
> 
> > So maybe the name should now be less "snprintf"-like.
> 
> Please, its important to stick to semantics for such well known type of
> routines, helps reviewing, etc.

My bad, will change the function name to arm_spe_pkt_out_string().

> I'll keep the series up to that point and will run my build tests, then
> push it publicly to acme/perf/core and you can go from there, ok?

Will follow up and rebase patches for next version.

> I've changed the BIT() to BIT_ULL() as Andre suggested and I'm testing
> it again.

I worry that consumed your (Arnaldo/Andre/Dave) much time, but very
appreciate you guy's helping.

Thanks,
Leo
