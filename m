Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951512B5A3D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 08:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgKQHWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 02:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbgKQHWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 02:22:49 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39736C0617A7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 23:22:49 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id j205so28741671lfj.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 23:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W4i9NQ6OsoFN+e3Rm0o5pJgxWmU5+u//PeH5iAlvI+Q=;
        b=WfYfJ93D2b8j/Ccxn/+u4A+b7M0oMztWQkICt8e/T2MyRer7AGAAZ8bcl/iScxkC10
         zbPD91sa/oGENgF8pCuiVYmsHN3/lrQIKzqM/aG0A5sSb4yw0XAVcnzaLjNwxFXCYq1u
         jdtX0Jt/GfV1ihXGwMbOV+f1omfzXxlRDGWGI+a8gfOq+BrD2OgqZZeTW7OAeQSW9ekE
         ZixbcRj0ZqSBfa6lYDt2LPFq6jHbtW/8bePoSvE5Wgacuz2XKsXCEpf7LlA+1MmHDBYg
         A0qPJviPSleIQa2o/nDYmYsif6kFgz8uPgz1VNrEbS7bN9jwR7IeGwnYfrNK/WAkuT33
         4i2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W4i9NQ6OsoFN+e3Rm0o5pJgxWmU5+u//PeH5iAlvI+Q=;
        b=em4iMF2NpgerAmpH9J3ZJqRV+ZwcLGXeUl4gw8DHhBalFnUH9zWg24LN2lhLRw9DWR
         DU/DPVOA4SdhkXSWc/V0A81XR+KRXEsPrJGO0QA+uNO0nslqKATHv8BTTPqmBtRdbNDg
         /KezBCznCqux29Z73pTTpYTQ5nrp6KVHf5+0swYXE1DSnUzj4Lgf7yGZJDhGslvlSSKY
         +WqqCXJXxBW8hh+ytCXAr2gfOkRkpQQ+Wj77aQk9yyY/I3l80n/H8XUpxhHY4r9GjCVr
         p+BtjCIZ7RCTlgQbuAUgPdqprvbxYQGZqFs4JrzYy4ckBpDNdZI7JAA6MBD0m8H6S0VS
         A+mQ==
X-Gm-Message-State: AOAM533XV8jVLeoWMregMC0iaZnXC9LjqmbG3qJu4rlzXXDLTo/hIKTl
        Z95XGNy2ZM/Qj0HboQDBxwix8YmvWOXBej2qwtaMkA==
X-Google-Smtp-Source: ABdhPJwO/2yfXmZ1Vt+DpDaiiQD3/ihK5JLFFsvm+jmuo6EweYkqBMdWs0coZNIQajHnfl8gDcLNZBNL9t49PS/n6RI=
X-Received: by 2002:a19:4bc2:: with SMTP id y185mr1104940lfa.243.1605597767312;
 Mon, 16 Nov 2020 23:22:47 -0800 (PST)
MIME-Version: 1.0
References: <20201116054035.211498-1-98.arpi@gmail.com> <20201116054150.211562-1-98.arpi@gmail.com>
In-Reply-To: <20201116054150.211562-1-98.arpi@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 17 Nov 2020 15:22:35 +0800
Message-ID: <CABVgOSmgf3WzYge79LwnJ0QWjZ37AASNJJZ7KV7BX2d++-7_QA@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] fs: ext4: Modify inode-test.c to use KUnit
 parameterized testing feature
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Marco Elver <elver@google.com>,
        Iurii Zaikin <yzaikin@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 1:42 PM Arpitha Raghunandan <98.arpi@gmail.com> wrote:
>
> Modify fs/ext4/inode-test.c to use the parameterized testing
> feature of KUnit.
>
> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
[Resending this because the HTML-email demon struck again! Sorry for the mess!]


Thanks: this is working well over here.
The only (minor) issue I've noticed is that the diagnostic output is
too big for the default log buffer if debugfs output is used, causing
some of the messages to be dropped from the debugfs results file. But
that's clearly not an issue with this patch, and the actual combined
result is still present (and the complete results should show up in
dmesg anyway).

Tested-by: David Gow <davidgow@google.com>
Reviewed-by: David Gow <davidgow@google.com>

Thanks!
-- David
