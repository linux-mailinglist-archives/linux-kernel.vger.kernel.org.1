Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E6B2B2AF7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 04:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgKNDRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 22:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgKNDRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 22:17:53 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725ECC0617A6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 19:17:51 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id s30so17100006lfc.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 19:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=toERlzzL8WsCdEJfo/3bQq0LwXblt9dO26uWe3e3YTc=;
        b=V7otNblMuyZJjoIlSQV8V3el9jARxmNTrT4RNaPNgCDMAs6a8ZyF72bmMx/Puc7Z4B
         fTlnLfxV+9FVrwnZTwLcBybPWeVSZid1maToFquae9JPCw+wLluljYJWKP0aFiHbKQ+a
         C7UpxYgvZORZD8n0v8Ad5ZTGd8NYrz9W4r5EUDeltqDSuoIhDJT2ZZ3wtq62iCaYQgkw
         uGmjfgCLmoirVbHly8G9MdrrjFWCr2LBQUiWPxfaX+zBUEguGmVOpw8Z6HYyGdad67MC
         4i3mDgKKMnweBfOtBTVpeeSAgrLlGbhOY6BX9KMwPwrGxlGmX6Iz1cdceIL0DXQVChXf
         618A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=toERlzzL8WsCdEJfo/3bQq0LwXblt9dO26uWe3e3YTc=;
        b=Ru5x2OLnHsd91bgvh2g0B0/1WOWpIaNmWXqaV1IT34cCMtQ0aDaIJJmlUmnTXZ41vT
         x7ztr/bJlC1I7AFnY4RiJE53/RVrsqcUiSNn2U/vVSi4Ewk/CBaUUuucKz98PFvOBCvU
         sKaJiRbZ90sZrVYqSteeEMZ7WQ0TyqCL6YIOTz44pgwvgVBF3AbLBh6fLEEL/c/EJom/
         KarOeccMRPsdrhnT/emlPajsyQBwbNAGcM933uO/pEYv49Qko9xkl2FQ5tKpZMrdUpgL
         zmszBiHg0NDjBx3UhQUjVx9WNOxcPw7DsYIfuMvAb/4xl6h1o65D09cE8UEtRgT37ie6
         gzkA==
X-Gm-Message-State: AOAM531BlV8DzKh8MInWz5lbayfaJWrJmJUGyyYgKZ5zW0IyKBbJr0Wg
        TTzqjHESkG0BXsd2+G3jhas/W5fhjt9nvmkdh9xEhg==
X-Google-Smtp-Source: ABdhPJzbOz34I7Z/noAxv/VgqHN/KtzJ/v+YY+qrROjrv3c/EYOpfeZxrDMfk5BeKnwQG9XwDsNMt8EnbVtsDL0qJGE=
X-Received: by 2002:a19:5e5e:: with SMTP id z30mr1879264lfi.277.1605323869521;
 Fri, 13 Nov 2020 19:17:49 -0800 (PST)
MIME-Version: 1.0
References: <CABVgOSkQ6+y7OGw2494cJa2b60EkSjncLNAgc9cJDbS=X9J3WA@mail.gmail.com>
 <CANpmjNNp2RUCE_ypp2R4MznikTYRYeCDuF7VMp+Hbh=55KWa3A@mail.gmail.com>
 <47a05c5a-485d-026b-c1c3-476ed1a97856@gmail.com> <CABVgOSkZ9k6bHPp=LVATWfokMSrEuD87jOfE5MiVYAEbZMmaQQ@mail.gmail.com>
 <BY5PR13MB29336C5BE374D69939DCADABFDE90@BY5PR13MB2933.namprd13.prod.outlook.com>
 <CABVgOSnJAgWvTTABaF082LuYjAoAWzrBsyu9sT7x4GGMVsOD6Q@mail.gmail.com>
 <BY5PR13MB293305FE7ED35EC2B2C81AF1FDE80@BY5PR13MB2933.namprd13.prod.outlook.com>
 <CABVgOSn0vUvHFTPPnFGCmg0pEotwr6TQXQieRV=EMqs1QmFYUw@mail.gmail.com>
 <20201112123706.GA2457520@elver.google.com> <CABVgOSkjExNtGny=CDT1WVaXUVgSEaf7hwx8=VY4atN5ot10KQ@mail.gmail.com>
 <20201113103056.GA1568882@elver.google.com> <CABVgOS=0Qm-Aa5qgh3PRxbcV0-2ZZaQCm-4HY0dx8597oY+yXw@mail.gmail.com>
 <CANpmjNNmzzuHpJOVV2JAKdgA48fxmqtXjDDOUg0e4+08kfQEXg@mail.gmail.com> <9c20815b-40df-d1c8-112f-e8d9732333eb@gmail.com>
In-Reply-To: <9c20815b-40df-d1c8-112f-e8d9732333eb@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 14 Nov 2020 11:17:38 +0800
Message-ID: <CABVgOSnkZ2f8JaXEUnCBS=7d7bgnCbKtp8QM1AUdVAuwQ9t69A@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] kunit: Support for Parameterized Testing
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     Marco Elver <elver@google.com>, "Bird, Tim" <Tim.Bird@sony.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 14, 2020 at 9:38 AM Arpitha Raghunandan <98.arpi@gmail.com> wrote:
>
> On 14/11/20 5:44 am, Marco Elver wrote:
> >
> > Arpitha: Do you want to send v7, but with the following modifications
> > from what I proposed? Assuming nobody objects.
> >
> > 1. Remove the num_params counter and don't print the number of params
> > anymore, nor do validation that generators are deterministic.
> > 2. Remove the [].
> > [ I'm happy to send as well, just let me know what you prefer. ]
> >
> > Thanks,
> > -- Marco
> >
>
> If no objections I will send the v7 with the above changes.
> Thanks!

This sounds good to me!

Cheers,
-- David
