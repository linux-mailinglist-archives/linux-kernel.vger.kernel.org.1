Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9B426DC81
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 15:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgIQNJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 09:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbgIQNJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 09:09:08 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E21EC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 06:09:06 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id u9so1104593plk.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 06:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EPhqMoh56IwlomezpV7bUA2GhqD4gsP45pnIJn8fDBI=;
        b=lQsGBLbWY2kcQ82vLfnmoL6IH/qgqIDrCnST3XhMd9AoMR6c4Tu8GVfOIB78QKb7Mu
         RbUWt9+7Z1FGMgTa5mYQRgUJvlj3VrYBkGNxqvivlB44pl4IudI9Xj6NfwNNZidP8rjZ
         crpRVDHQhPKXFS+tnztOJG1VqSUBRa5TwYQfk8qCuSPNiQ65KS3/kq9/oC40Ok13dKqF
         r6caHdl38SQtNi+JAb6EnGGzPRRzJb/9W6PPZ32BihQp2wvRdCGFtV9UHOQxkKXM23QG
         tvIfWM5PA0mmseUPRqKW7gi04v5u3AGM6mQyqo73JXEzupEbr1VfVAXDTKzOX67GI5Wn
         FgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EPhqMoh56IwlomezpV7bUA2GhqD4gsP45pnIJn8fDBI=;
        b=hzjihAaodyK1vnN9FS3k28hD4Z0+JupDLLS9w5Tr6qVNMNfHjTnuLWQFs/C8CAevfA
         2JkJNBxYNP8S8vpImZWEPoOyBx9EGbwfU+okoBWwy8w+FC/S7gAFIgNK5N2BRlanwcCa
         KSW+HCRzX4DbibldxC5UtnkWcVURHQXikUOphahy2JnJt2pe1ajp0k1V7K8Me99sD8IF
         UHpiCmO5EkaHDrulfv3CE8O73hVVMmvi+DQGFY40bzoD5Bd7FVtqpmqImkbgfdI39P+4
         6cCjP1zNTU/FPpZGTxTqgX9kTMd89YYcjJ/2zWHpbWg0EoSssvNKjdkJhTZgkoH866QW
         loTw==
X-Gm-Message-State: AOAM5309c7cPUNLUnIeHsfMMQgbBgRCnjvfHcIi6349lFSAxMs2MDAEe
        /gxE7NqTK8JGDnukMR9x/VVX2w==
X-Google-Smtp-Source: ABdhPJz1RC10B1kD75VwpjKu21dK2v2wlK7bFQuvpp3GKVQEhlTeQXzpxApNlngVukQ2vbgjtt/6kQ==
X-Received: by 2002:a17:902:a582:b029:d1:cbfc:608f with SMTP id az2-20020a170902a582b02900d1cbfc608fmr17372312plb.37.1600348145509;
        Thu, 17 Sep 2020 06:09:05 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id 187sm20845436pfx.174.2020.09.17.06.08.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Sep 2020 06:09:04 -0700 (PDT)
Date:   Thu, 17 Sep 2020 21:08:54 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv3] perf kvm: add kvm-stat for arm64
Message-ID: <20200917130854.GG12548@leoy-ThinkPad-X240s>
References: <20200917003645.689665-1-sergey.senozhatsky@gmail.com>
 <20200917100950.GC12548@leoy-ThinkPad-X240s>
 <20200917101219.GD12548@leoy-ThinkPad-X240s>
 <652f10660f09bd608b825233713f775a@kernel.org>
 <20200917110028.GB3049@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917110028.GB3049@jagdpanzerIV.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

On Thu, Sep 17, 2020 at 08:00:28PM +0900, Sergey Senozhatsky wrote:
> On (20/09/17 11:21), Marc Zyngier wrote:
> > > > On Arm64, ftrace tracepoint "kvm_entry" doesn't contain the field "id"
> > > > or field "vcpu_id", thus it always reads out the "id" is 0 and it is
> 
> Right, Leo, I saw that. I put "id", because there is ... well, there is
> nothing we can put there. The trace points on arm64, unlike on s390 or x86,
> don't contain info which can let us map trace-event to vcpu_id (even
> (void *)vcpu would have been rather helpful).
> 
> > > > Essentially, this issue is caused by different archs using different
> > > > format for ftrace event "kvm_entry", on x86 it contains feild
> > > > "vcpu_id" but arm64 only just records "vcpu_pc".
> 
> Exactly. I wish trace-points were less of pain-points.
> 
> So 'perf kvm stat' on arm64 works, but it's not as feature rich as on other
> platforms; at the same it's better than nothing, I suppose.

Agree and I don't want to introduce complexity at here.  So it's fine
for me to merge your patch v4 firstly and later use a new patch set
to support "vcpu_id".

As you might have seen the discussion with Marc for new trace events
with "vcpu_id", another way is to add new trace events with "vcpu_id"
and then enable "perf kvm stat" based on new trace events.

Either way is okay for me; except maintainers have different thinking
for this.

Thanks,
Leo
