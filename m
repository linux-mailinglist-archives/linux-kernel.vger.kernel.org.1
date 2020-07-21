Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F178A228ACD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 23:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731490AbgGUVRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 17:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731335AbgGUVRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 17:17:11 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F41C0619DB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 14:17:11 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id u25so130126lfm.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 14:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+yHNt87DNg06st5Xvcn/k5gkCvt7pppBHpC/nXo6E+w=;
        b=eoUGsPTaLCi+OvvgDt1WVz1j91QiOdJd4Oq2XThqlHQuBV2m/mmlOa1jj8LR6xjFci
         eYqT7+fgO3LWo4uXASHbEhi+l8B4qwpGiW5Q0l23MVEVF02we1Ji9ygGjb3FLO+FP1Mj
         t/a+zOg0W3Se1DdWUn92n1LdvJUR2fKNauo4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+yHNt87DNg06st5Xvcn/k5gkCvt7pppBHpC/nXo6E+w=;
        b=JZtn6cyOkO2jlH6W/j/jiIkIqZEeDb9QGMbPgQPEmdLKIsTu9u5sVyOIpUlSDASRQF
         Lmmf9Rf3S5Ifc3dvTtYaSldCzEOak6yFh9IqrIBfaOiNd245DtwTV9IE4yXuelKnO4dl
         VFxnTLRByX6buq6woRisapwFgiVjNkamxrQK5CSPESmDDk1/f/Me8gGSynRCvYmeQiff
         DuMXJFraJMHtokuh0i8wzKW4rhm7YFOBOr1CYs27a/v69V/P4lUlgnOdPH9ptfT4nFys
         Gl9ROkq6ttQ1d2LMrJewanhicqq/lE189oqD00U8SgKh49RVgBbiIHalUaqyVwkezj5H
         Uh8g==
X-Gm-Message-State: AOAM5313+UAg2EKJt9hWjRccx8JfaoFCjM2hIH1CmmJDTt2dhJN+uHsd
        2O2BJOsBg8rUh5A5sSiA7jYunehPSmU=
X-Google-Smtp-Source: ABdhPJywtRqK9QVdoVbpVWMgdjx5Vh5EBxtJE5NgJnLrlrQSOXhOu7t3KInsbsO+uDmjmw4YD+sEJg==
X-Received: by 2002:a05:6512:3193:: with SMTP id i19mr10407230lfe.183.1595366229639;
        Tue, 21 Jul 2020 14:17:09 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id m14sm6846663lfp.18.2020.07.21.14.17.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 14:17:07 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id y18so98006lfh.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 14:17:07 -0700 (PDT)
X-Received: by 2002:a05:6512:2082:: with SMTP id t2mr5445624lfr.142.1595366227470;
 Tue, 21 Jul 2020 14:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200721202425.GA2786714@ZenIV.linux.org.uk> <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
 <20200721202549.4150745-4-viro@ZenIV.linux.org.uk> <CAHk-=wiYS3sHp9bvRn3KmkFKnK-Pb0ksL+-gRRHLK_ZjJqQf=w@mail.gmail.com>
 <CAHk-=wg4DXWjV0sHAk+5QGvkNqckJTBLLcse_U=AknqEf8r3pw@mail.gmail.com> <20200721211118.GB2786714@ZenIV.linux.org.uk>
In-Reply-To: <20200721211118.GB2786714@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Jul 2020 14:16:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh59vJmaH_jWWxpr97XdQfUpOTJgMEA11qzvMwJFjB0VQ@mail.gmail.com>
Message-ID: <CAHk-=wh59vJmaH_jWWxpr97XdQfUpOTJgMEA11qzvMwJFjB0VQ@mail.gmail.com>
Subject: Re: [PATCH 04/18] csum_and_copy_..._user(): pass 0xffffffff instead
 of 0 as initial sum
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 2:11 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> > > But I didn't check. Maybe we don't have anything that stupid in the kernel.
>
> I did.

So then the commit message really should have said so, I feel. That
would have avoided the whole worry, and made it clear that it's not an
issue.

                Linus
