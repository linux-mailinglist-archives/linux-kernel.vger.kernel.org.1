Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DC72F8692
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 21:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388784AbhAOUVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 15:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731816AbhAOUVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 15:21:30 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F5DC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 12:20:49 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id md11so5705287pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 12:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5FQr0UCI/MaWdaqFfV2TlbW914Ru2H540vOm4R4tCNg=;
        b=XHitNSqGdGBzX4wnF2kiAEEigqDAIJf+b2Y0O/qCdnk/L+IB59vOGCOWshd3Ud7+XH
         76dBfR1PKxJ0CW5nGN8hEQLspA6Gm9ixRKQd5ivDnLbo1V64In44W+aEkYxZAt6guBNQ
         cNkKAKgDdpMBeL2ixQR73/IDBqCLB/pFWzS0vNPo9bIDcsSh+bNDfthz85SP1n/owfNh
         qrgqQnsmhb32eSC8kIt3LsW1Oyqhq1lcfOFqM12TIBDif8UfDq55Onq5/MwLAETwZDVM
         TJpJ5GSkwn1qpjILYhaLD4q9Dn+/cOA92hlB1Z0mb1dV75p4QiTE9txEWubeOwi/zjXI
         7xZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5FQr0UCI/MaWdaqFfV2TlbW914Ru2H540vOm4R4tCNg=;
        b=mTOxwBoLVqgskxvJu5ZZ+DQpqH94EBDa81tcLzCrL6iU1FaNg/jM/dF2ghL5qCbWbG
         cfqPpJDPIt0IBiCmMDGKIH+cM2PJWEEh1iCKJwPve4vcScBV4o5coKfZcW3Gn1igahCL
         M8MWwoL/gEPbWUgUL8HeP+883kZGFJ93DXHpB7dfIa3hZJM25UDDAbU+uTTt+LBZJv52
         Z+g+1oLNeiYhiG8gpTN6VifOlC2atHQCHSXdVY2hbURErU5Gz7gdR2mYdsqGvR6PJWdH
         AJUkboWi9kdpr+N9HGXTboaJQ5N81CkmdAuBuPKrEevZLELsfXxBh9eMjB0DkDrd5A8e
         C5jQ==
X-Gm-Message-State: AOAM530QGHB4NLy/1YZKEJ/msdcICWNMH8QL2AeOhm0lIkDcxoISy5lt
        xnGg3mx4aijCEi9RsY2DyGCKpeK7nRZPWiU/yAlmag==
X-Google-Smtp-Source: ABdhPJyv0m03B81aOGsnzS5skp35T91GNbgpsPhDMyV35buImCVHa0cTzz6OHrToB+fUT8W6HcRvihOXC4WlsIot3kA=
X-Received: by 2002:a17:902:ed14:b029:da:9da4:3091 with SMTP id
 b20-20020a170902ed14b02900da9da43091mr14215466pld.29.1610742049240; Fri, 15
 Jan 2021 12:20:49 -0800 (PST)
MIME-Version: 1.0
References: <20210115191330.2319352-1-anders.roxell@linaro.org>
 <20210115192803.GA3828660@ubuntu-m3-large-x86> <CADYN=9Kt597LsfW=Aq6v+kWr+ja+55_+Z3s5mFaJULa+9J4EfA@mail.gmail.com>
 <20210115201342.76nssqtbs4kttgts@google.com>
In-Reply-To: <20210115201342.76nssqtbs4kttgts@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 15 Jan 2021 12:20:38 -0800
Message-ID: <CAKwvOdnzxsuSb3LPkuLYMfH0jeh65dFt8BsHPa8wM+6e69Rc_w@mail.gmail.com>
Subject: Re: [PATCH] mips: vdso: fix DWARF2 warning
To:     Fangrui Song <maskray@google.com>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 12:13 PM Fangrui Song <maskray@google.com> wrote:
>
> http://lore.kernel.org/r/20201202010850.jibrjpyu6xgkff5p@google.com
> Personally I'd drop DWARF v2 as an option.

WIP :P

-- 
Thanks,
~Nick Desaulniers
