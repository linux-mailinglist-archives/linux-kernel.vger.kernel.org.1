Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2845D2CCD01
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 04:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgLCDHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 22:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgLCDHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 22:07:04 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C08C061A52
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 19:06:18 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id u18so564276lfd.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 19:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iabHWxPKR0AIdSLCLpw/C98fo9E+QLOwHBUfijaTHQI=;
        b=AUQsOHkBeiTCRFg84V/yDRz2/jWuR3J0fKxAp52o5M4SXIBufUW4si5duvf/GMoL1C
         swixKu+RjjKlS6wWmi4ALcrumj1I3aXZdS3MNLe1WCmrWmDvWBzShKcYMihiWhfD/m6N
         kMhh5OXRHnmsZXfwMXP9kMPMPmky/B5InN+Z7an/boun8bZWXBkBS5Xp8iH3BFKxlnO2
         OFzLiyFIa7fykoAUXq1E1plqt4Ik2j1wNwUAAzhg7P0BKM1wibFomM5L6v97uI/U8AQl
         aTtaFfU5eHGq9ATsbpKp41UUmEI4AtWOrmwXDBBXiGUlyFLutxxVot0xPwYyTmWlKAoN
         SKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iabHWxPKR0AIdSLCLpw/C98fo9E+QLOwHBUfijaTHQI=;
        b=bdjAFodaLVgjtnZwo1jjOqL0i672gNllqPlmAsJz/AdPJ1pb0Ej5w92RcucvW+Bq4l
         Tb04oQIlVTb6ONsAhMvnYVfOc9fmVn+pZzkAAG0RCbsTlUuk5SYTyoylijcJPpVw/TGQ
         Sugtmi0kVNDK+9PcODTxweCy9n2haz7U8wM+Ul8Sqfml21RslRzx/ufUKZa7edCLE8/p
         ovt8BUMS1oMs0THl7k3CwU82FEwT25GcWdpB1ykLCSArZFPqdUstinuIsVPbyOsxW6h+
         K6gkLOfg3UcYVm7r9l7y56N38hHeE3dTiA6rvdLXnKvyv4J8gFf7nFSIYSA20LLkrUxx
         5ceQ==
X-Gm-Message-State: AOAM530ZEYD/yhwlkeHkqSkBOMi7R5KxTZO1ts39dJWt22QXksjBrQvD
        W2VhF6u5s6unh6kUPPv0EMk0LnodjyGyOBafn5Yv4Q==
X-Google-Smtp-Source: ABdhPJykgUoWnXraVCTndySD7LalvFP87smyvD+6cUr/lw5/huv1uwshhaw6Nrv3Vqyp1o0ghF0lO5Qq8V2d4oHcPfs=
X-Received: by 2002:ac2:5102:: with SMTP id q2mr439864lfb.165.1606964776658;
 Wed, 02 Dec 2020 19:06:16 -0800 (PST)
MIME-Version: 1.0
References: <20201202190824.1309398-1-dlatypov@google.com> <20201202190824.1309398-3-dlatypov@google.com>
In-Reply-To: <20201202190824.1309398-3-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 3 Dec 2020 11:06:05 +0800
Message-ID: <CABVgOSmiXDS=wGe0XPvr2BDqg+1be43TLFLE8fW79ZNPUYpNYQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] kunit: tool: use `with open()` in unit test
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 3:09 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> The use of manual open() and .close() calls seems to be an attempt to
> keep the contents in scope.
> But Python doesn't restrict variables like that, so we can introduce new
> variables inside of a `with` and use them outside.
>
> Do so to make the code more Pythonic.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David
