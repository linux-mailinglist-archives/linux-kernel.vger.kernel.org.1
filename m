Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F36F1D8C48
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 02:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgESA3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 20:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgESA3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 20:29:34 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA6DC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 17:29:33 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 202so9663654lfe.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 17:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lp5YS4wnqdBmdbNdBQYAqe4C1skHr56PklzUDuGNt/o=;
        b=HhfO0c/8Afa39iKCJTB/VymbLZle1h5CJm8AufmRSEUwBn1RFOp146dtIZ9YMMYJwD
         RIsrpTUNyS/4zSVsfHF+DajZ2AXyTU0XqO0JvcLfWy5PnMEXZeMdzN+/JsfVpklg/2It
         hYaSG+aYP1iUn/RWWyuBF1JUePeDCVxxVxWUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lp5YS4wnqdBmdbNdBQYAqe4C1skHr56PklzUDuGNt/o=;
        b=k8QqDp8+QTZuz0bqQ4USM6cQbTFydNjBo8PDIpYJBQuJA2xqD6CBXamg4sA4FP/Jjv
         rGqqEz1HJU6Vp+GPgqasGD0yoWNs7uTxjF1CbypqBEe4aFbv/8JjPX45eyzUKr6B3eWl
         cC1lEjeUk9vdVd7Jvi2CSS6iYJtsvb1LIAAcZimJDczepEyziooby4wns3rfmfvgyAqH
         n8ylYZIW6mEzgU43eUgS0jQfG7H4XwVcjeOnN6d4/tC1E+ylh0InBtb9x3JN2Z8sCIJj
         p5YtusK+jExON8nhFVoMUOCiJfCHAu1AVG0fKqBQjMtlAFE+YxfF/kNj3G33T01GO38p
         AreA==
X-Gm-Message-State: AOAM533ZO++w8Sd8hW1z3IzTrntskTLT+5h1rFb3IZt8QvexO15vtUO/
        MTbsDe9cplPj/CJ8lFlLnd5OQVa8Q1s=
X-Google-Smtp-Source: ABdhPJzBOiDKZPvSWhVax8a/iFsouuf5pNGevrUgIhFnsUExvgmBX71zfIbqhqTYrAB8YE2BBNGyAA==
X-Received: by 2002:a19:70d:: with SMTP id 13mr13512664lfh.60.1589848171412;
        Mon, 18 May 2020 17:29:31 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id x11sm6384151ljj.15.2020.05.18.17.29.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 17:29:30 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id b6so11839130ljj.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 17:29:30 -0700 (PDT)
X-Received: by 2002:a2e:8956:: with SMTP id b22mr5686169ljk.16.1589848169813;
 Mon, 18 May 2020 17:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200408205323.44490-1-natechancellor@gmail.com>
 <20200518093117.GA719849@ubuntu-s3-xlarge-x86> <CAKwvOdmXgYThHRDpt5dFZy5T1zS6MYQhcBNcq6-rsuc5fjiE6Q@mail.gmail.com>
 <20200518183513.53b94f11@gandalf.local.home>
In-Reply-To: <20200518183513.53b94f11@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 May 2020 17:29:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiwom6EF4DqStcZD0cJwXRMwAmLx2Z-wcn5xTiaJpgEkA@mail.gmail.com>
Message-ID: <CAHk-=wiwom6EF4DqStcZD0cJwXRMwAmLx2Z-wcn5xTiaJpgEkA@mail.gmail.com>
Subject: Re: [PATCH] x86: mmiotrace: Use cpumask_available for cpumask_var_t variables
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Karol Herbst <karolherbst@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        nouveau@lists.freedesktop.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 3:35 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Linus,
>
> Are you OK with this patch?

Yup, I don't care deeply either way, as long as we can get rid of the warning.

                Linus
