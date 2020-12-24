Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC22E2E28FA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 23:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgLXWMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 17:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728851AbgLXWMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 17:12:47 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B45FC061573
        for <linux-kernel@vger.kernel.org>; Thu, 24 Dec 2020 14:12:07 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id o17so7115506lfg.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Dec 2020 14:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cF4gWolnJ46SGXTA3iokNOBB6rTqdEEZbYRTGkpsaeY=;
        b=MvN0X/pmZwkxtKecxvq3Z5pdlyl3EtTze+Z/yCEDu4b+SBlGjOcH1rOroJM5CAKO2d
         ITncuvq/yXDOOzWHRGHBxnx2Yk6KCultAXCzFrl30b7WASF+P2W8FEVBViFVWHaonL6i
         RJF1yoSkCcW9/Z4/6u/dtlCgNbEAFhP6+36dQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cF4gWolnJ46SGXTA3iokNOBB6rTqdEEZbYRTGkpsaeY=;
        b=FgOub5oJnY8UbgZPt+wINrBlbLaJVIEpd8DeJ4ggbF0n62Eu1w2OYBAA57g48bWWbV
         mK3zX67gwhs9ntspRNYbdAueO0e87LkYVn+6eo/cXkLpwYmwfkE+wrtWo0ElsQtSfRNW
         1LHJgAkbjlfHNa378YnkEL3mvi4DOl5lCXWQyIR0o778Bd8osdwqoER//qq6l0mw+NMG
         xICeHCJ9VOO6dw5LgCt5rD4fRxZ0ZJRqm4v08p4PJeRTv5b1qsl16dcVVdaUUPXSYWdF
         RGlp/25maHM9xQxktJnIzv+ofjX7T1XllF2Hp7ud1Bad/VAI/WtT7DmKNaYBOLAEerc8
         uObA==
X-Gm-Message-State: AOAM531yPDgzWSQOsRBWAMOqwmfZMtKQFhgDZVYqk9R5ng69T8ZosFVx
        DwEcf/iXCj5JRABb0oz0JQjIUn/cbO+L9w==
X-Google-Smtp-Source: ABdhPJwl4pSRZ+ys6AIQkgRQ4sVVhoEXcHgECNUqyvJdhwR8B4RrTLaeQ0KLcMiEOaMZiQxAldXMkQ==
X-Received: by 2002:a05:6512:3222:: with SMTP id f2mr12990602lfe.25.1608847925580;
        Thu, 24 Dec 2020 14:12:05 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id g13sm3764719lfb.43.2020.12.24.14.12.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Dec 2020 14:12:04 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id h205so7113187lfd.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Dec 2020 14:12:04 -0800 (PST)
X-Received: by 2002:ac2:41d9:: with SMTP id d25mr12053752lfi.377.1608847924320;
 Thu, 24 Dec 2020 14:12:04 -0800 (PST)
MIME-Version: 1.0
References: <b73e7af1-25d3-1e68-c810-3858abc489d7.ref@schaufler-ca.com> <b73e7af1-25d3-1e68-c810-3858abc489d7@schaufler-ca.com>
In-Reply-To: <b73e7af1-25d3-1e68-c810-3858abc489d7@schaufler-ca.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 24 Dec 2020 14:11:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi3kt+T+Xyh55_ca4sUxGinhr7Y8scsNSANjGhvcy4FCQ@mail.gmail.com>
Message-ID: <CAHk-=wi3kt+T+Xyh55_ca4sUxGinhr7Y8scsNSANjGhvcy4FCQ@mail.gmail.com>
Subject: Re: [GIT PULL] Smack additional patch for v5.11
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 4:43 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
>   https://github.com/cschaufler/smack-next smack-for-5.11

That is not a tag.

And I really want signed tags for non-kernel.org pull requests.

Digging at that repo, I do find the tag, it's
'tags/Smack-for-5.11-io_uring-fix' and it has a proper pgp signature
from you.

So I pulled that one. But please don't make me search for these things.

                   Linus
