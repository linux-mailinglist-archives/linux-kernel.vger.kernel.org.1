Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6762A5FDD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 09:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgKDIvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 03:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgKDIvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 03:51:02 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8B9C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 00:51:01 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id 23so22063482ljv.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 00:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sDsafJWCwrLrG2/+xFl5bOz8OxK+Pcz3yiEjIfibRFA=;
        b=uN5cwPl/OnTA3voNDn3l/4URDFS0cUGOnuPXpne0LKuyX5D3iJJl6kG8HMdXcW6pEZ
         2nzn6hYLdRWuyBKlHPxLT59ZlRM7/2l0nw5a8Z2DP3IqN24PjvqytnCSlTOWaZSdCZpJ
         OmSl+YHynt+wsMrEyRk22ahNeJP2pDeoE0eRhM3hUs2tdrx/WCtnWNCaR3Hc0NF8gddm
         1vd1zoukS3qIz4/EofMiIjdqMUxYCC4AN35xSAu23MCNsGMdzVAlD3TJg9w2w9RrCQv6
         bMtArNH8BH1t/fuYvAIEB3QiU44UVTsy59bZotjLFWov50hqtl4FYRNDJVWbAS+tvYMw
         uwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sDsafJWCwrLrG2/+xFl5bOz8OxK+Pcz3yiEjIfibRFA=;
        b=jmgQijJhnGfC4w1jm6z8dVFOWpVILi7KIf2vBOMBoHArJ8UxvjuM3LfE4+FdZzzB+v
         KVMT07ejZPMRM5+rResIQm3f8wA7WaQXj1urGrnLuyDnFJNlmITmplIqXafnHQAPd7Hp
         TPYNB3s+QanJ3sdLENYPnRM7/+93hKOcT6FdK9lkvyehLdnvphbXWwkjDMZ5WJNOVVyg
         aLMrWi/2x9oFg8/O1ycr0PyugH829BKFbn3ZZHpD6vksGlXR812PVOPmYYRGN+hvRi/z
         3MdvHlp8Mt6a9uLXTUpzqrtah2jD7xSXDdOeNfgsYnLz+Qhx10Bw1Y/fh/7F2u8aYUhD
         Ndmg==
X-Gm-Message-State: AOAM530juzG76JoGVsiU+uyrf747gTg17VFQkxoQhWjz/WnvB4smGugK
        pVgW/RJYfH+7jr5tvinJ6KLfgFzXkL4MltkxhHs=
X-Google-Smtp-Source: ABdhPJziqXgF98ch4Eh+EBdlSP4tqXFrka/+pgo8zsXxwkvQRX74u7Rayj94zlqgj2b0RdAawjn4OPjOEA4ILtb4gc4=
X-Received: by 2002:a2e:8116:: with SMTP id d22mr9644010ljg.331.1604479860115;
 Wed, 04 Nov 2020 00:51:00 -0800 (PST)
MIME-Version: 1.0
References: <20201103054810.21978-1-dwaipayanray1@gmail.com>
 <CABJPP5DkJ3gwZDW+FBShs3Yo8z6GfP4LSMRW4hO5hL+fVXjShQ@mail.gmail.com>
 <e9d540c35ac04f0bb69e26d29c76c7cbd5693df8.camel@perches.com>
 <CAKXUXMwH+tEBSV6xA952xQQFe+HvdJ5ew6V=n63sk89enj6p7Q@mail.gmail.com>
 <6c275d95c3033422addfc256a30e6ae3dd37941d.camel@perches.com> <alpine.DEB.2.21.2011040848420.21917@felia>
In-Reply-To: <alpine.DEB.2.21.2011040848420.21917@felia>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Wed, 4 Nov 2020 14:20:29 +0530
Message-ID: <CABJPP5AFd-i+haMCis7EUAht7hfRqB3sqCp34S=AUUsZ2aRjCg@mail.gmail.com>
Subject: Re: [PATCH v2] checkpatch: improve email parsing
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Aditya Srivastava <yashsri421@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I agree with them as well. Let us try to establish one common way from
> comments.
>
> Dwaipayan, if you code this into checkpatch.pl, maybe you can also add
> some hints on conventions for tags in the kernel (process) documentation
> to explain the rules and conventions we think make sense.
>

Sure, I will do that.
Maybe I will start afresh on this patch with all of the above views into
consideration. Once accepted, I will try to go for the documentation
part.

Thanks,
Dwaipayan.
