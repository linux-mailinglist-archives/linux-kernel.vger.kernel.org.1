Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECAF929FBBE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 03:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgJ3Cui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 22:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgJ3Cue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:50:34 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4AEC0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:50:34 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id y16so5388632ljk.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C030SNL8ytYALn4NBSzKMY+djTDRmDtL+lOw/6SUbHM=;
        b=UCfTk7uMOAOzQcb/VvndxncmgbOs7L5QoOsM1VqMLv72Bp5P7f9rIxux442H9WGfiX
         0tymPqZhINabpNeKxBMsW0wa8ree2d81hNcfuqlt0A2EafNJuUqCw2u2wpwF3VnKhD0S
         /QtV3zFTZmvEU1tecICZRF5BgawODRvIs2Vz1uzCEMJpDKtctlcdKziXgrlQjzLif2xD
         aBstmfISwfrHUpWS3BdpLDEMrcGPdcR/1f3oxg7ENHQnf97piB7uZ5NQeamBRNSoAwh8
         SjHQvD5BX61roU/X2MUzMmF0QSqAKbxCJJHaxLpADdKDD/ifcwnUgXBmd04A2bTLlNaE
         Ip6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C030SNL8ytYALn4NBSzKMY+djTDRmDtL+lOw/6SUbHM=;
        b=AfamB7CfWmbrAIAFrqQFZWgfPVJpWI6VX5ke3H6dV665kiIhtkPLfPegndMvEGLMHw
         A2wKPqgz6UbVtNi848DX+3PzBXOsTtHHXOiunKIdm5U3KwG3Cu9w2ebK5dk2su7XuPhq
         Hzho9Pht/9rvoJ0kxOkmJOkKh6lOHrRixeX//lISxzV5yL4kcKbK1TgQyIPNy6Yw4qeA
         ueuGij+5ze7OjdJL6lvT1Mq2Vz9wkCZ7frc9OFQY8/Q9jFlkRarJy387TFOFruvJrNIV
         sHKJOcFLZEbU6pGAfNNemuqm/jlHJI/9FuBtrEPK2wssyGlhDIcrLs2FsZdmiwVUzbjY
         qCCQ==
X-Gm-Message-State: AOAM531tYfO8DI55MR9YxOvAEi+8b32m9F0YLeAmwvHPlbiaEnVPT3ya
        3s+NLZxyxsOCypK7sNTcCmxARNsAUaN3zpH5o5Gu3g==
X-Google-Smtp-Source: ABdhPJyhKmaQFQjloELZVYyipnpl1QPmddMqBl1H13KxiIV3UlurGqLCKHtxKCyf6M12wAB9WBq5NCbeAJx4FoIIBcw=
X-Received: by 2002:a2e:b6cf:: with SMTP id m15mr98951ljo.74.1604026232451;
 Thu, 29 Oct 2020 19:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20201029131649.182037-1-elver@google.com> <20201029131649.182037-10-elver@google.com>
In-Reply-To: <20201029131649.182037-10-elver@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 30 Oct 2020 03:50:05 +0100
Message-ID: <CAG48ez1sfD=Pe9BZRVZK4wpWp9ci91eMrrYus+a4uaactVUVtg@mail.gmail.com>
Subject: Re: [PATCH v6 9/9] MAINTAINERS: Add entry for KFENCE
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
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, joern@purestorage.com,
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
        Linux-MM <linux-mm@kvack.org>, SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 2:17 PM Marco Elver <elver@google.com> wrote:
> Add entry for KFENCE maintainers.
>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Reviewed-by: SeongJae Park <sjpark@amazon.de>
> Co-developed-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Marco Elver <elver@google.com>
[...]
> diff --git a/MAINTAINERS b/MAINTAINERS
[...]
> +KFENCE
> +M:     Alexander Potapenko <glider@google.com>
> +M:     Marco Elver <elver@google.com>
> +R:     Dmitry Vyukov <dvyukov@google.com>
> +L:     kasan-dev@googlegroups.com
> +S:     Maintained
> +F:     Documentation/dev-tools/kfence.rst
> +F:     include/linux/kfence.h
> +F:     lib/Kconfig.kfence
> +F:     mm/kfence/

Plus arch/*/include/asm/kfence.h?
