Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879272A36DB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 23:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgKBW7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 17:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgKBW7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 17:59:40 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE48C061A48
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 14:59:40 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id e16so126613ile.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 14:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WLiJRSZDtXGLiZVllQRQGLaR655Hs+rHimHW4Xh2uCI=;
        b=Xy3858vI46rSFVYKB418SAOtR8xhErvTZXC0kS+Ij+3CB4nlLReyT5p3EwP4xoog4L
         U806CmRrgiBeMvnFR4bOG0UPR0HyT64powJ0A0+HYqyoTEAuNKkPtFKD+xrD169A8aRt
         nAKCxmCfGuYjcYJ1rOVxcBsaxXPzKGcevIudZafx35sBjHUhzBjsHE2A/1nCjqOnNVjH
         1SL+rWTrPweOT0JQ1kX/3wzU6QrNZ2+Jw2kO1SvCOdgPO/j91ror3BcgyeGl40KLm9mk
         z8s1LkKFkuh37nPpbtLMWNh0S9upOlQ3xg8jUDN16g7AjO8BX1NFG3X5XzOli2F+fR++
         hgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WLiJRSZDtXGLiZVllQRQGLaR655Hs+rHimHW4Xh2uCI=;
        b=K09T2gRFgMVRbv+1JBqXTNSuRRtJFjP2SLcXkpnluVSch6h88b+yyEUbSKl+DDW92y
         YYTB8mVwIFfKKi0LGOdOlg52G+t06MVqc8KCENyShyBuI+8JyXW6V7KLs164YnjF2ceM
         nkxZrZQZDMgTESeMYkV7N4JTyML98jEgp5btQ5NzIULMD2udBEA2gWROHycz91Df5zu4
         dYBoqxe8k9dk05/TfIwsiIxfUnIDkqSPsj/Xv2+IGtlBMMY5GBvah4/hU+H7wC63vESu
         pVzJ0CENTIuRiLrm2wXuP5nhmlcI6Uh5ttFUPmX1C6ObYpE5wUbL2jMKRSZTLaroxKvx
         ejsw==
X-Gm-Message-State: AOAM531NqgnYN9y2c3NSH/uIUf91u7Z6GrjYukkolxwOopnqELUujZXG
        zVsZRJs4SFJXxYybs3vtmyeOOplMY9gaOoiWT1YMPsG0ELk=
X-Google-Smtp-Source: ABdhPJyZNnTkCSdkuybuVtY86i/+/FnnBOksLKyQaq2Hm6+ySGMeObsSQN7r9P2EcPwqKSnG9hQemoVBYyH9q3cbPz8=
X-Received: by 2002:a92:7914:: with SMTP id u20mr12435436ilc.203.1604357979556;
 Mon, 02 Nov 2020 14:59:39 -0800 (PST)
MIME-Version: 1.0
References: <20201027233733.1484855-1-bgardon@google.com> <20201027233733.1484855-4-bgardon@google.com>
 <20201102212715.GD20600@xz-x1>
In-Reply-To: <20201102212715.GD20600@xz-x1>
From:   Ben Gardon <bgardon@google.com>
Date:   Mon, 2 Nov 2020 14:59:28 -0800
Message-ID: <CANgfPd8BDze5yeiyzdmdOV_p3as-KyqeoQuCT5UEAaUx6OMJ=A@mail.gmail.com>
Subject: Re: [PATCH 3/5] KVM: selftests: Simplify demand_paging_test with timespec_diff_now
To:     Peter Xu <peterx@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Shier <pshier@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Huth <thuth@redhat.com>,
        Peter Feiner <pfeiner@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 2, 2020 at 1:27 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Oct 27, 2020 at 04:37:31PM -0700, Ben Gardon wrote:
> > Add a helper function to get the current time and return the time since
> > a given start time. Use that function to simplify the timekeeping in the
> > demand paging test.
>
> Nit: timespec_diff_now() sounds less charming than timespec_elapsed() to
> me... "diff_now" is longer, and it also does not show positive/negative of the
> results (which in this case should always be end-start). "elapsed" should
> always mean something positive.

That's a great suggestion and much clearer. I'll make that change in v2.

>
> With/Without the change above:
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
> --
> Peter Xu
>
