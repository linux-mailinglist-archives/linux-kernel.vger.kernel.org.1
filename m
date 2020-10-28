Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B778D29D310
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgJ1Vjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbgJ1Vjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:39:36 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD81C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:39:36 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id m13so621569wrj.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OhXbzz0jUd2ouNJ1702kQcn1I79hMZdbasdGII6+h5c=;
        b=J+qnhlZSZCGqciGOVRu8UXOc5yQJ29bhxTt7RSiOhmCifYU1PKHZCXpB1FBcxdFz2p
         Ed/r1YxqFraYaFSJPi3eywD5yqxq7FuGKtUlqSTCA+MKYJ3A+b6nAO8HLl/Hqxkva6Lk
         7X5yX828znMMHRwhaB3fE6jRLs9TEq5MbG/sffZB6P/26cRNV0quiAVCXwEbfcFih/e2
         mBGv3fOev51hKNDHSzUFxt9ObKpbs/m5i2k3sHPBOu0ln5M8yliSXSO+MCIaJmeMCCDA
         jVxPqGGFsnzYWn6lHzGdBk37o7xQMdIvkTFjn1IiNm9b68bIaRfFzt68NGkQaV5S/qoO
         Fx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OhXbzz0jUd2ouNJ1702kQcn1I79hMZdbasdGII6+h5c=;
        b=e0X1stNBnl8OmzStkoI1fRAizRnbqA4+cuieYunsdg1K37Z1RPkQvU03hTfkXobdnp
         hmvv1w8q95N7oRMKTETvuccwo28lXfF6uZvRHdBcXR9O3fEQLzmzU1TgGfDrX+/z/QrR
         5WVpbf2Mn95DfMKtvoaqFseGV/xcBHIPG5R44SWOit0hmZfJFRJHyqg5ck6xQ/69nMoW
         1mALtvMGWJzen38cGy2fwe3D61RATTJVh57yet3YHp0yJk0YPKYZmzZGxSqOS1gjOPEZ
         dysmQx7sdD+3VJhL5Gz3X50ovZ/ZjARuMdm/FwKcBS/huM1PDIKMDbEKF7jSBm6J1qQ+
         gfJg==
X-Gm-Message-State: AOAM5335O8WW3w6kfD4Eex2bdvORZwr6LK0ReL13XRhy/lVntNNxMZeD
        avrAwJT5g0Hr8b4853DciumnuxcxhCWGI9sHXp242pd9iV9Abw==
X-Google-Smtp-Source: ABdhPJy9hdrKih3/vRFFidKj98rZEPTvPBdg5+TSPoXdegSBjJdPRD5dmnhatqK8xsL/a8GhM8JT6nGOQbpt7j58Yok=
X-Received: by 2002:ac2:561a:: with SMTP id v26mr1920118lfd.167.1603854058688;
 Tue, 27 Oct 2020 20:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <20201027184909.20881-1-rdunlap@infradead.org>
In-Reply-To: <20201027184909.20881-1-rdunlap@infradead.org>
From:   David Gow <davidgow@google.com>
Date:   Wed, 28 Oct 2020 11:00:47 +0800
Message-ID: <CABVgOSmtTK=V8EFL8KTmN+e+pP6HKZQo+LMsmqG3PnxuhFtZ9A@mail.gmail.com>
Subject: Re: [PATCH] KUnit: Docs: style: fix some Kconfig example issues
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 2:49 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Fix the Kconfig example to be closer to Kconfig coding style.
> (Except that it still uses spaces instead of tabs for indentation;
> I guess that Sphinx wants it that way.)
>
> Also add punctuation and a trailing slash ('/') to a sub-directory
> name -- this is how the text mostly appears in other Kconfig files.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: David Gow <davidgow@google.com>
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Brendan Higgins <brendanhiggins@google.com>
> ---

Thanks for fixing this!

For what it's worth, I _think_ we could get away with tabs for
indentation in the file without Sphinx actually complaining, but it
does annoy some of the editors, and as far as I can tell, Sphinx
converts them back to spaces in its output. I'm far from an expert,
though...

Regardless, this is:

Reviewed-by: David Gow <davidgow@google.com>

-- David
