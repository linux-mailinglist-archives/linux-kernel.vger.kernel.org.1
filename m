Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC1C3289A02
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 22:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390942AbgJIUut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 16:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgJIUus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 16:50:48 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD41FC0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 13:50:48 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id q123so7866559pfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 13:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wTcVu4oETJELTBTO9Qx9E6QynJ2qRr0RMhI6Lss/kRo=;
        b=KqYQl09nzQc++fy4ixa3glsFIZci442nzrDG0fcwmUtpLC5GdJDecIntJaTr9BnU+k
         mHQV/FbLDSsp3LtFLsRl7T/zeVjv8Twr5lMP3mtNmGjMAycuhVQeNy6SxCfwNFW224a7
         0aTYXNZMa+jC7UhkQneYNe71rwlQlYDitPklTa97BhEb1m7+mN8rfc5c/j9aVJULK1tK
         kXqyUbQ8e7mPIF4Q1d2YHCkekuQkecmqoGoo0ONdt2lmrDHm6ydQldiw4prAm7vbUqOP
         n+GwBtayqaO7D2OKGp8MP+pmirMixqou37jYYe5EkC/YvLWRQkL0zC9bekBaZ8qVYuhi
         m9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wTcVu4oETJELTBTO9Qx9E6QynJ2qRr0RMhI6Lss/kRo=;
        b=V5/RusxESAIOWcWtiwL6VRWmoTNcalJUy2L9YBD/QWuSspiGgqJneMAN02/Nj0zI3X
         qwHCF1g/D7u6xMtcu4YtNX4Y6uTmfO/7Aam8n3vfYxQC+JHAqSt09DPN7dtU3ZTVihEm
         LJm4TaQp3mM8kLcxMX2T7ExsAbbMuufiXS5cp5Imu8i49FwvWDyvF1qSLg0oq/6DIBKn
         LzoTY7j4fjJpJyrKM/FBbzELjb4mAO6q9kg83yPD9R1z3nMJD1jzVsV4WufUNenoQTGv
         /WM2yj1LP261lDLg8n+N9nUwIpgac2UI082Wj73DRxN3Xz86TbKFv+sNelBXULFhxJ8G
         MAUg==
X-Gm-Message-State: AOAM531Yah1D4AL2BC19PshOAwzXBl5FJ2mddgJtpDJ+db7NKUuipIZ8
        7clVSWO/VDXUS2FW+U57g6vF7A==
X-Google-Smtp-Source: ABdhPJxVwMwto7ILPuyT8ZZD/+7fv8lOOoXOE+RyXcVgFRqpvoLioQmgYU/5kPeWbujatJFVPXtviQ==
X-Received: by 2002:a17:90b:19c9:: with SMTP id nm9mr6551747pjb.6.1602276647984;
        Fri, 09 Oct 2020 13:50:47 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
        by smtp.gmail.com with ESMTPSA id n4sm10981225pgv.89.2020.10.09.13.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 13:50:47 -0700 (PDT)
Date:   Fri, 9 Oct 2020 13:50:41 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v5 00/29] Add support for Clang LTO
Message-ID: <20201009205041.GA1448445@google.com>
References: <20201009161338.657380-1-samitolvanen@google.com>
 <CA+icZUVWdRWfhPhPy79Hpjmqbfw+n8xsgMKv_RU+hoh1bphXdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUVWdRWfhPhPy79Hpjmqbfw+n8xsgMKv_RU+hoh1bphXdg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 06:30:24PM +0200, Sedat Dilek wrote:
> Will clang-cfi be based on this, too?

At least until the prerequisite patches are merged into mainline. In the
meanwhile, I have a CFI tree based on this series here:

  https://github.com/samitolvanen/linux/tree/tip/clang-lto

Sami
