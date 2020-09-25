Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337F5279214
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgIYUdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgIYUXp (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:23:45 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF278C0613B1
        for <Linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 13:23:44 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id z18so2056086qvp.6
        for <Linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 13:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=waezLtsQz1iNKoRoNrkVmzJDRAS58+4ZClQEXTTFmzA=;
        b=EKICFhZCyuIfVjG8/EBbeviyqHHJk0nzyhX8o48i/us+vhME4OaguCxVVVC9u0hbrD
         m3WT1VnCTH3CaHNBcgIVUZhQypDuprAxO496/K9XRQ8adQo8JLqr7sAIwLK5G3Q4UpY6
         UF6EWeZK7MoVmxB/Kg7ci8nzBkfyacM6yGA3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=waezLtsQz1iNKoRoNrkVmzJDRAS58+4ZClQEXTTFmzA=;
        b=eZJ95gVzU7pyjAxq5eLfg+plvoxi5Mm25hvQTcZdmKGZ9VZ1bCrDl+Ihg2GDJYFcji
         1V/h0iFPEAFYefP1j0qRLhsdepgJ+F2RG8h9tRs/wqWabXDlTxGkgW3RqYCmzgrlIGu9
         HGXVfVld56T9K8FShkaI0edmQlBL6bneqh57DQ4j+9x3qU5iX2yi0cmIUewlwzb77fNy
         lSc9bVxuClJc419/+h6tRoYrsbzJ6OQLg9mwnEMeK99Zy2PiKoUjcB+GCnpSC8t83EUp
         EWWKI2dW4c/SlkNcvrMp9mlpuXrxoMSd9UT418wBzRr1nt5nPo3B3j0cwB1MvIOmAz5u
         iW3g==
X-Gm-Message-State: AOAM531rrQWdrvR7kUEN6Clu8vrsEb9CyoyjOEWgnGI0dMGoWZa1kfyv
        T9mnUjtEi3GYnd3WeZjhiCg1NA==
X-Google-Smtp-Source: ABdhPJy36Tu6N5UgMv1x52Vfmxfn6XdC2Ra47k8DSCLwWPPTFQ5ls+JKh90kBkMkjS9tkkeV06LYTQ==
X-Received: by 2002:a05:6214:a90:: with SMTP id ev16mr422057qvb.50.1601065423969;
        Fri, 25 Sep 2020 13:23:43 -0700 (PDT)
Received: from chatter.i7.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id y73sm2307090qkb.23.2020.09.25.13.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 13:23:43 -0700 (PDT)
Date:   Fri, 25 Sep 2020 16:23:41 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     "Jin, Yao" <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>,
        Kan Liang <kan.liang@intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v2 1/2] perf vendor events: Update CascadelakeX events to
 v1.08
Message-ID: <20200925202341.k2zznmefv7tcjsnc@chatter.i7.local>
References: <20200922031918.3723-1-yao.jin@linux.intel.com>
 <20200922031918.3723-2-yao.jin@linux.intel.com>
 <20200922194232.GA2505291@kernel.org>
 <4db737f2-0705-5183-6971-9031acfd123b@linux.intel.com>
 <20200925180527.GA2883319@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200925180527.GA2883319@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 03:05:27PM -0300, Arnaldo Carvalho de Melo wrote:
> Things like b4 help with this and probably have to take into account
> attachments as well, that is why I'm adding Konstantin to the Cc: list
> of this message.
> 
> Konstantin, is this case covered? I.e. patches that get botched and then
> require attachments to be sent to then gets processed?

Hmm... it's complicated. The trouble with handling corner-cases is 
unexpected ways this can affect other mail. For example, what do we do 
when we see a patch in the body, but also a patch as an attachment -- 
should the attachment win, or did the developer mean something entirely 
different ("this is the fixed patch -- I attached the previous version 
for your reference").

I am working on a service that will automatically "explode" pull 
requests into patch series, so this may help work around this particular 
issue. For example, a developer would send a pull-request to the list 
and cc "exploderbot@kernel.org" (or someone else can follow up with a cc 
to that address). When the bot sees the cc, it will automatically 
convert the pull request into patch series and send it to the same 
recipients as on the original pull request.

This should help avoid the problem of terrible mail relays and nasty 
mail clients.

B4 can already do most of that (see "b4 pr --explode"), so adding the 
remaining bits should be easy enough. If this functionality is 
interesting to you, I would be happy to have early beta testers.

-K
