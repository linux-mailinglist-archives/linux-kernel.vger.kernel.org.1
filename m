Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3FD429F684
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 21:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgJ2U6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 16:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgJ2U6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 16:58:33 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E085DC0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 13:58:32 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k10so2920974wrw.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 13:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1YTlLHaZTomYHKwfcUy/D+8HN1lrU93CEOhzQLhOkog=;
        b=h4A/ikGd2x0QjnM7BDtzaj8rWGQ1JekzD++OKlsyct06sMrY3C5pG8VL6o9J0HjGKU
         86vGGFoX7K3ESSlqlIkHxUuAwBJmdPPQWriM2ktZxcOnqicZ1UoYmpMfBItPsxnffeOw
         TUWk9SvsqD1wDQ8Y7JF8rPoRhAzk12g7YraxXs1jJvRQX4BejlnZcwcral5cANWLnFzZ
         PkID87RB5AvYvwGto3ATm4XuiacJ6yKdR4A6nw/5oEjb6fVc5K7URu+3llRUv0ilV/H/
         nv+/OwfyM0OGf7exyNE4Gq3ETMbmkE7r5nH9SIwlKVWYhowI61B74bUh/vYgR9QNk2z3
         +6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1YTlLHaZTomYHKwfcUy/D+8HN1lrU93CEOhzQLhOkog=;
        b=qg1Pszh+HWqM+s36NxxVpE5l2U8Q/fmbWEX776W/yw8ugAWxvC2zmGHBhxWVy5ihuR
         HrQyjNu7n9aPf+BaCLBvuGFgkb0OWRVI9zccXfkXbaQy3VBwWAAubcIu2YC2jYITx/a6
         910f7XPXK0i1ViaON/Gsh+zh+2WFLRpuPiFq4wUbnGtG35mqud6WhMR6WFuHwiuqx8gI
         39hVwlnKFvsQX6vAZyC6tfY9dAdm89aT2SWrrr6dbnfyoFp6UsoJ68KaK/NdFAM5evk3
         NJ/KbgMtE2oOoYUKIz4nqXRwzBEWQ+7+OYRc6xb8z5/zuJDkJGUJrzovOkykWQZ2iEyT
         5OkA==
X-Gm-Message-State: AOAM532R/ezT9mnQVFVCyK7gya2zk7TMMy3qm0r1eJgG3m1inP6i5Ub+
        pfuQtI6oSY/MVbaLMy04mFYQiN2yr40u/FUUWB8WcQ==
X-Google-Smtp-Source: ABdhPJz8nRnqhAyn65fIeXT1oxvuKuBIXxNJHpCr66drvovx92JC+9vsb2EGudLDV/Bny8AkAZfsxM6EaEtjElw7iHs=
X-Received: by 2002:adf:f20e:: with SMTP id p14mr7739130wro.376.1604005111278;
 Thu, 29 Oct 2020 13:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <20201029160938.154084-1-irogers@google.com> <CAEf4BzZGUmtrATZnExcUY-BaiCmUKBDo4QOb6PjfumhYG_3c5w@mail.gmail.com>
In-Reply-To: <CAEf4BzZGUmtrATZnExcUY-BaiCmUKBDo4QOb6PjfumhYG_3c5w@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 29 Oct 2020 13:58:19 -0700
Message-ID: <CAP-5=fUiJnfv_W4MLFEvkAQvKYDANrJ8Ymuzdmr0XnCF3rgk0A@mail.gmail.com>
Subject: Re: [PATCH] libbpf hashmap: Fix undefined behavior in hash_bits
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 1:16 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Oct 29, 2020 at 9:11 AM Ian Rogers <irogers@google.com> wrote:
> >
> > If bits is 0, the case when the map is empty, then the >> is the size of
> > the register which is undefined behavior - on x86 it is the same as a
> > shift by 0. Fix by handling the 0 case explicitly when running with
> > address sanitizer.
> >
> > A variant of this patch was posted previously as:
> > https://lore.kernel.org/lkml/20200508063954.256593-1-irogers@google.com/
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/lib/bpf/hashmap.h | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/tools/lib/bpf/hashmap.h b/tools/lib/bpf/hashmap.h
> > index d9b385fe808c..27d0556527d3 100644
> > --- a/tools/lib/bpf/hashmap.h
> > +++ b/tools/lib/bpf/hashmap.h
> > @@ -12,9 +12,23 @@
> >  #include <stddef.h>
> >  #include <limits.h>
> >
> > +#ifdef __has_feature
> > +#define HAVE_FEATURE(f) __has_feature(f)
> > +#else
> > +#define HAVE_FEATURE(f) 0
> > +#endif
> > +
> >  static inline size_t hash_bits(size_t h, int bits)
> >  {
> >         /* shuffle bits and return requested number of upper bits */
> > +#if defined(ADDRESS_SANITIZER) || HAVE_FEATURE(address_sanitizer)
> > +       /*
> > +        * If the requested bits == 0 avoid undefined behavior from a
> > +        * greater-than bit width shift right (aka invalid-shift-exponent).
> > +        */
> > +       if (bits == 0)
> > +               return -1;
> > +#endif
>
> Oh, just too much # magic here :(... If we want to prevent hash_bits()
> from being called with bits == 0 (despite the result never used),
> let's just adjust hashmap__for_each_key_entry and
> hashmap__for_each_key_entry_safe macros:
>
> diff --git a/tools/lib/bpf/hashmap.h b/tools/lib/bpf/hashmap.h
> index d9b385fe808c..488e0ef236cb 100644
> --- a/tools/lib/bpf/hashmap.h
> +++ b/tools/lib/bpf/hashmap.h
> @@ -174,9 +174,9 @@ bool hashmap__find(const struct hashmap *map,
> const void *key, void **value);
>   * @key: key to iterate entries for
>   */
>  #define hashmap__for_each_key_entry(map, cur, _key)                        \
> -       for (cur = ({ size_t bkt = hash_bits(map->hash_fn((_key), map->ctx),\
> -                                            map->cap_bits);                \
> -                    map->buckets ? map->buckets[bkt] : NULL; });           \
> +       for (cur = map->buckets                                             \
> +                  ? map->buckets[hash_bits(map->hash_fn((_key),
> map->ctx), map->cap_bits)] \
> +                  : NULL;                                                  \
>              cur;                                                           \
>              cur = cur->next)                                               \
>                 if (map->equal_fn(cur->key, (_key), map->ctx))
>
> Either way it's a bit ugly and long, but at least we don't have extra
> #-driven ugliness.


This can work with the following changes in hashmap.c. I'll resend
this as a whole patch.

Thanks,
Ian

--- a/tools/lib/bpf/hashmap.c
+++ b/tools/lib/bpf/hashmap.c
@@ -156,7 +156,7 @@ int hashmap__insert(struct hashmap *map,
                    const void **old_key, void **old_value)
 {
        struct hashmap_entry *entry;
-       size_t h;
+       size_t h = 0;
        int err;

        if (old_key)
@@ -164,7 +164,9 @@ int hashmap__insert(struct hashmap *map,
        if (old_value)
                *old_value = NULL;

-       h = hash_bits(map->hash_fn(key, map->ctx), map->cap_bits);
+        if (map->buckets)
+          h = hash_bits(map->hash_fn(key, map->ctx), map->cap_bits);
+
        if (strategy != HASHMAP_APPEND &&
            hashmap_find_entry(map, key, h, NULL, &entry)) {
                if (old_key)
@@ -208,6 +210,9 @@ bool hashmap__find(const struct hashmap
        struct hashmap_entry *entry;
        size_t h;

+        if (!map->buckets)
+          return false;
+
        h = hash_bits(map->hash_fn(key, map->ctx), map->cap_bits);
        if (!hashmap_find_entry(map, key, h, NULL, &entry))
                return false;
@@ -223,6 +228,9 @@ bool hashmap__delete(struct hashmap *map
        struct hashmap_entry **pprev, *entry;
        size_t h;

+        if (!map->buckets)
+          return false;
+
        h = hash_bits(map->hash_fn(key, map->ctx), map->cap_bits);
        if (!hashmap_find_entry(map, key, h, &pprev, &entry))
                return false;


> >  #if (__SIZEOF_SIZE_T__ == __SIZEOF_LONG_LONG__)
> >         /* LP64 case */
> >         return (h * 11400714819323198485llu) >> (__SIZEOF_LONG_LONG__ * 8 - bits);
> > --
> > 2.29.1.341.ge80a0c044ae-goog
> >
