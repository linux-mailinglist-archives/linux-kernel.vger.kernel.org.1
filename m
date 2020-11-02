Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155A12A2F35
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbgKBQFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgKBQFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:05:31 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15503C061A49
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 08:05:31 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id h6so18115146lfj.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 08:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=9U519WWw6TDZQ33OGLBJjsTVpJX0KjTb47DTCYLn51c=;
        b=XBV11D3hMt0/lfz9orFTgOOHlkoSQTctDbSg30moLGCdPgHOGNBT6FfCLaCAVj4WGa
         GhjwiMUe5h5n0Vn+tEGbS1TbCOIYAom6xf5QDMiiPS7g5zXqzBnsmmJ3l2IN489ApUv5
         k7cWGSbweRACd/yeHVpAPke8JH1ybfrvlMjFy6VaYUdHVc4lnjLUev7mJ01y71mXtQpQ
         2t670Gw5HTK1J4kDdJrS4wSKcDirN+bzET+JNUBw3+eHGYYQjwP4InUCC7MtoJtv9lQf
         FaBPFNc81s1hN8+Gb4+UHQxwj80ShQtGaNH70Wf/eus0CYugdc6oCSVQZ6R2quU62Ds9
         8REg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9U519WWw6TDZQ33OGLBJjsTVpJX0KjTb47DTCYLn51c=;
        b=cu8kKk5CGg1qHNPqTiaQOKyTuk5DL1QfhXIxmE1/01/7Gqk/xC1lQdxIdLMGiJv8aV
         UMWIQt5MTWQaXxqJZxQ9kkAlhvjDkjSsZV5Y+skTj2Q4BrXduPwwg54A6NIs8Lb5pdq0
         SiF8SXnFzjXqzWCAsRvKdW0ULUApuSOSSYJaqk1UKBPy5I4GzV54zLf9AO0R6TLzTdZl
         Q/bFJszpqE29Zih5L9dn32yhmvKdAY1GwpXn5osu4uifi0Wu1BZLfKCz+F5159jC0IwN
         tMIBUF8R+FT53bnHPhnAf969pxb1hnxGPAcwFc4a5reOCXQZ4HKA9bJlhTfCLNucx2Wy
         yBpg==
X-Gm-Message-State: AOAM532hxHtgIuadpgJKOexuDhTL7PwY+oBjE3+hVMhDCNKuS9yPbn6x
        DLp1yh623eIfh3TGDeqY+YPqUaoKy/a4f7GaOMOgGA==
X-Google-Smtp-Source: ABdhPJxjYJNDcYkH0qMdTqpGns+/hG9ww0wj6ml3rzKOFmjcnOaTneJ5oikwOAMEMuPoUy/AsnwP0V3wKqrSsAp0hkQ=
X-Received: by 2002:a19:4f0c:: with SMTP id d12mr2342827lfb.576.1604333129223;
 Mon, 02 Nov 2020 08:05:29 -0800 (PST)
MIME-Version: 1.0
From:   Jann Horn <jannh@google.com>
Date:   Mon, 2 Nov 2020 17:05:02 +0100
Message-ID: <CAG48ez2A6o423ySWfdX7s3fzrMSVn1YLYk2EnE1dV0fgZQS45g@mail.gmail.com>
Subject: ASSERT_GE definition is backwards
To:     Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASSERT_GE() is defined as:

/**
 * ASSERT_GE(expected, seen)
 *
 * @expected: expected value
 * @seen: measured value
 *
 * ASSERT_GE(expected, measured): expected >= measured
 */
#define ASSERT_GE(expected, seen) \
__EXPECT(expected, #expected, seen, #seen, >=, 1)

but that means that logically, if you want to write "assert that the
measured PID X is >= the expected value 0", you actually have to use
ASSERT_LE(0, X). That's really awkward. Normally you'd be talking
about how the seen value compares to the expected one, not the other
way around.

At the moment I see tests that are instead written like ASSERT_GE(X,
0), but then that means that the expected and seen values are the
wrong way around.

It might be good if someone could refactor the definitions of
ASSERT_GE and such to swap around which number is the expected and
which is the seen one.
