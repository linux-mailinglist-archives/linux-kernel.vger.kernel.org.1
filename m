Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC412A59EE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 23:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbgKCWSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 17:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730242AbgKCWSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 17:18:01 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03598C061A04
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 14:18:01 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id v19so15845590lji.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 14:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z0GfssSb9lxM+saQ7V+1ta/Gt8yaqMW9vqfv+WXLTwo=;
        b=FeZn//b1sOnMrO86t7PxeEcDowXD4Ju86jS3F2Ovkk/9uHRoKyViEL8FoAGe1M6Dsc
         24tIc4S+LsQx1PS2ucPg54frQ40elJZesPOG4kOonbBE0WF0P0m3JpGqm3g8z3hK1YjI
         qT/pfOxKrxqo9F2RMyW1BXUdBXaedR4oQLBXmSeAA8UtMPxdMoGaY8uOb2ar5h6kPNc1
         osM55zh33/mU4PHPqktEsnB0Tixgu/FqGh2MLGmhFh3pbpMLU4QhKYtapoUre6M+T3Ka
         7147e1t/Jwu0QVFanpXFlTNpj+ZCQNIC6wt7G7UdezZJAZEj4v31ZuoTvI9gA8os5HX6
         Wgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z0GfssSb9lxM+saQ7V+1ta/Gt8yaqMW9vqfv+WXLTwo=;
        b=RGEuLlspXdNLfaU1PWDcgurvO9XxdCvg/RM3QQKUba0eLKNsNoorebyC3/2lqUTpp5
         BaMsgYdseQDuCgd5n4ZLcvc5J9R+pfHnSQqZgLuu3A+R/axpQUJkNhJCWyNq+/8vV6wK
         oT1yo9cGuNwac+jUnBRU0o3x89Bk9L5WPe4S3nr2OhnL7UFNq8/ctP2nvCx6FUSEWuHy
         FVwvY9TtZDetpPy6itXg2OOr0Q3RlPjmnBElWmSnzs/I0mzX7mMUD8dZg+KyaFbRFRAS
         qcDrmKwidoYWV7SjXSA0wMq58RG/xcfjn6rE+Gmr8ya6ijrSy347iGPpp1uKzKYiaQFB
         dZBA==
X-Gm-Message-State: AOAM533DR4NqY8luIOiqIpgtrr7ZMY+uq5yfBTefL42JHwQh9rT05O8S
        YIMHbwfKrJOV9YNLMAKm3bXbzeKkTXOtsABOui5TBg==
X-Google-Smtp-Source: ABdhPJx1YLpbLOmJgqu3eQzQ+sA7YY36W5ObSZZ3HEKf4jnleqY9lVAuhTWuMxAk5yJC8NxBNIaDG96Wmw/e3PGz5t8=
X-Received: by 2002:a2e:9c84:: with SMTP id x4mr9140798lji.326.1604441879292;
 Tue, 03 Nov 2020 14:17:59 -0800 (PST)
MIME-Version: 1.0
References: <20201103175841.3495947-1-elver@google.com> <20201103175841.3495947-8-elver@google.com>
In-Reply-To: <20201103175841.3495947-8-elver@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 3 Nov 2020 23:17:32 +0100
Message-ID: <CAG48ez0=_ZoUsZvh99UJo7GziiTqZUKYgqHzvd784a-Fs-kEcw@mail.gmail.com>
Subject: Re: [PATCH v7 7/9] kfence, Documentation: add KFENCE documentation
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        =?UTF-8?Q?J=C3=B6rn_Engel?= <joern@purestorage.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        SeongJae Park <sjpark@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 3, 2020 at 6:59 PM Marco Elver <elver@google.com> wrote:
> Add KFENCE documentation in dev-tools/kfence.rst, and add to index.
>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Co-developed-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Marco Elver <elver@google.com>

Reviewed-by: Jann Horn <jannh@google.com>
