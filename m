Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206642F723A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 06:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731810AbhAOFfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 00:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731537AbhAOFex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 00:34:53 -0500
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119A6C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 21:34:13 -0800 (PST)
Received: by mail-vk1-xa2b.google.com with SMTP id p128so1910849vkf.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 21:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ax6mB1CqVZukWAU1tjWp4UeICbzmILWOckaiTff+GZw=;
        b=Mmtw+vEcv+96LHq4ptHZUUyiqiIgq5C9cQJcctXZ374b2ayb8Mom4B0adLtxi0/JzC
         PDOyEprhCkCrq9EBxz6EGLRSMCcykPuujhFRdP5OsGMRnsDTh/maCmyMAC6KyQtZIsCw
         rFHTzAqycEp8n/+BJ12KRio0oK2m67UjX9iV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ax6mB1CqVZukWAU1tjWp4UeICbzmILWOckaiTff+GZw=;
        b=m0fvXRX+fQpsZlYhnPuaiK5/nMl28HOBEO94rvbbt0Ts+kHOGGnQTHV/7XVO7B5OC2
         dQ4PkKeZYHUIhTkaY4d03n00CyMkhwzW6qcHtGtuu4sRmfiBxxlKvQN98KXfxY4/lstG
         9WxKTDtI6vOxS9XR9E1E0KyzeuaBF5dOXZ2jWwzTzU9ewBANuTj9xWOBmLIzHYY3jjoX
         +Zx12HxB8Ylfn3lsYN6TNjbLM+tqVh33PHyctAazMw9WJQssLtBl28EFCT4xA6Q33F4M
         +3yD2wl4+qZCU5rnPgq4v0O0J+qcEPkUcC4xQayeTyHToXuDsEEBpfFZwNekbzmiA7ux
         zW2g==
X-Gm-Message-State: AOAM531lAKylR9Bztihf/zo9hKb+xQVStGZko9h4IMM0lyKazGGqYbjG
        lYnQ3eoqjFg1I0U8s67sp/gAXosrsYYynE/xWDWEeQ==
X-Google-Smtp-Source: ABdhPJwXNJSYdQjNrt7NEv4DcVveYiDrfEBOv25u+SOwBxLVCXD5muGOkDS70HOyAVKN2oIN7ef1Aim9049JarUf4T8=
X-Received: by 2002:ac5:c5b5:: with SMTP id f21mr8986198vkl.13.1610688852162;
 Thu, 14 Jan 2021 21:34:12 -0800 (PST)
MIME-Version: 1.0
References: <20201224114502.1.I41b9795e4b5bda7209eb9099aebdc6a29677391e@changeid>
 <nycvar.YFH.7.76.2101141314410.13752@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2101141314410.13752@cbobk.fhfr.pm>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 15 Jan 2021 13:34:01 +0800
Message-ID: <CANMq1KC84MykRrKROQdVUmFZerpw4okEb1dLfVhAu-JXw5=Yfg@mail.gmail.com>
Subject: Re: [PATCH] HID: google: Get HID report on probe to confirm tablet
 switch state
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 8:15 PM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Thu, 24 Dec 2020, Nicolas Boichat wrote:
>
> > This forces reading the base folded status anytime the device is
> > probed.
>
> Could you please provide a little bit more verbose changelog (namely what
> is the actual problem this patch is fixing)? Thanks.

Sure, I should have done this in the first place... v2 on the way.

>
> --
> Jiri Kosina
> SUSE Labs
>
