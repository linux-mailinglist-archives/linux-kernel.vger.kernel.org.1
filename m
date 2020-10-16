Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F43290702
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 16:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395419AbgJPOQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 10:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395315AbgJPOQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 10:16:29 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6023AC061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 07:16:29 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id q9so3994989iow.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 07:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8oMl9Jkv1ZhmQqJr+IcPPTV/Y4r187DO+Q/W5eroPvc=;
        b=Zx25PVzn+/qNJgQaylVU9Az2xn46DpG7B5r43IcTDYz/UdYnJglRvAeRDqso7XSA98
         acJgvKvLs2OLNjNhy79QUZKQtpoiJY6TQBGcWzwipe9j9Z9Ch82DZgUJ5WRrWT+fBM+9
         +C4A13usVg6Bq9u7WciUsYLN09iFUsb5G92VRRLJHFGMNzNunaQs82eTGybnvaXnNwX9
         4KncGpjhskNGgGOvPz+PJQVCv3KWNce1Xo5RfcQ2zhxtRpSsjRIaxuet/qnmWZeGE8YH
         rdQAvfnsETsAXPO/+vHbuHtmGFNnrFJLtuGDMjuXci1o9UWCBC4dao+l8c4aDmH/GGoP
         QKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=8oMl9Jkv1ZhmQqJr+IcPPTV/Y4r187DO+Q/W5eroPvc=;
        b=aqmj5FCR7C2m4TZA2xm0hqWnQ2UjZKlX1e7BHud3kgFxAyifJPg1i8+fSfa53q2KEQ
         IS6U0zQF9212NZrzaheuL4L45x7uODqOrtJQhmhGTJXFULiJHh4N/Oqzl9cOE4oaF4WC
         U0620PrJD7E0uA2bk/GqMOcE/uhDp5MxOCc3Iv4870+dTC7yLBTh9paEcVAjlXeUi8vK
         wim4E0J71wYVjENgTN6KbAscB+Ig7TmLsPjeZtiOp/zmVNMdR6xQ1aKYrhh/OviOpGjo
         dsPEWKxEqlW47fux+8SsbuPMaXj1gnk1HvOWCDLmidctDD/KkgoxHaXAmAEXgfcnIx9Q
         KDOg==
X-Gm-Message-State: AOAM530b8wq+8agbOR16ptzAYGSMhiQ55/g++ycLYKxRhFl2511KMKh6
        U0E4nJUSWJo0XuP7WR+0CHc=
X-Google-Smtp-Source: ABdhPJzOxr2qBCSvEp5x5x22SvZWr0OzvmD/nFSJXZhaa7gPOP51p2BuSsfwGV4xG7U9pZLczko0wQ==
X-Received: by 2002:a05:6638:974:: with SMTP id o20mr2909666jaj.37.1602857788584;
        Fri, 16 Oct 2020 07:16:28 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z89sm2405576ilk.4.2020.10.16.07.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 07:16:28 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 16 Oct 2020 10:16:26 -0400
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, x86@kernel.org,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] x86/head/64: Disable stack protection for
 head$(BITS).o
Message-ID: <20201016141626.GA1101574@rani.riverdale.lan>
References: <20201008191623.2881677-1-nivedita@alum.mit.edu>
 <20201008191623.2881677-6-nivedita@alum.mit.edu>
 <20201016111703.GD8483@zn.tnic>
 <20201016124301.GA1040839@rani.riverdale.lan>
 <20201016131545.GE8483@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201016131545.GE8483@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 03:15:45PM +0200, Borislav Petkov wrote:
> On Fri, Oct 16, 2020 at 08:43:01AM -0400, Arvind Sankar wrote:
> > You need STACKPROTECTOR_STRONG -- I was testing with defconfig and the
> > option is enabled by default.
> 
> And you need to write those things in the commit messages.
> 
> Please, for the future, always make sure that all required ingredients
> for triggering a bug are documented in the commit message, before
> sending a fix. Jörg and I were both scratching heads on how you're
> reproducing this.
> 
> Thx.
> 

Sorry about that. This config option I didn't notice before since I
hadn't explicitly enabled the option, but I should have been more clear
about how I reproduced. I actually came across this from the other end,
was looking at the disassembly, saw the stack check call, and then spent
a while debugging why it did _not_ just always crash.

Thanks.
