Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4110E2FC6E9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 02:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbhATBhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 20:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbhATBa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 20:30:56 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894FDC0613ED
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 17:29:34 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id o20so5070325pfu.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 17:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:cc:subject:from:to:date
         :message-id:in-reply-to;
        bh=41qPdxl0K0syAjBeibZGeyLNe7r3NMDV7tPcr9ieA/8=;
        b=bGUQT7oWpcvWIAUwxyxSpzsmg0cBS74+6pW1e7396OBji8kykFhR82a3l8XvYEmFtp
         sG/rx2HEEXqOwkNqpTBbgcPFfuc+1NVTr6X8hErIiTDYNMVOIz2becYdIyIYCt/cUIi7
         JB5CEYQeXlzR/R669cASV/W7pz4Wjqp+7tlcT8+QheC3/u0Li9I0Ux7v+PMqM+/qaaV/
         wzj0IacEYVHdKE23PtNp5ugkxPd5TtYOvLMYVC1N9ZS0qPzFqaG++udHnmHI3YTlEU1P
         1xVtRqL+dPHo+VYSES2ytNF/T4WKBTDwCqJyC9cMEnys325+SCgibAIcWWVli8xzYT10
         owbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:cc
         :subject:from:to:date:message-id:in-reply-to;
        bh=41qPdxl0K0syAjBeibZGeyLNe7r3NMDV7tPcr9ieA/8=;
        b=WgAVy+KqtGPkcrgcG8aEanBDWzp7k5r8MbBMEaG6oOawL/biDhjHQ2dFRhLNYQ+6BN
         FFd8E8CcR1QU/iv4KQlctx0/w6s1VSCAmQuszsAw1FaGfeW2XgrySbp1LgxONPeBWCu/
         8lCm2jxOU4Nq9KSLifYTUbNfcihzm3OmEyLSgn7yyLcowlkBKytfIL6b5h8+Cpk7rrIu
         i78R+UXnCeNebR2eix08jX9Atbv6p6Oqs5GXDK0LkusJQt/h570cNCGeORtsAhubVtHX
         PkG8WvjNu/x/iCdy8NWcWJMd2CHdC6Ls+APEQ1dWISq4FBhML7r/+uYfwvs0MDukACYC
         Rxfg==
X-Gm-Message-State: AOAM532ZjJLGu/PRU9Dkw/JUvCTnGkmge7T1Lglt4lG5TEwMeLD6uaTO
        RiXklPU3y66XJ6k6rVrd8Bo=
X-Google-Smtp-Source: ABdhPJyRdzZC3usx9t8xBAEtTNuZfTWyhGnxmiWjp9DXjmA/IgVvSM/BgwNPwXu9aXwWBtMTWamV8g==
X-Received: by 2002:a62:17c3:0:b029:19d:ce3b:d582 with SMTP id 186-20020a6217c30000b029019dce3bd582mr6856073pfx.18.1611106174194;
        Tue, 19 Jan 2021 17:29:34 -0800 (PST)
Received: from localhost ([116.12.58.169])
        by smtp.gmail.com with ESMTPSA id v15sm292473pfn.217.2021.01.19.17.29.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 17:29:33 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc:     "Christoph Hellwig" <hch@lst.de>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Jiri Slaby" <jirislaby@kernel.org>
Subject: Re: Splicing to/from a tty
From:   "Oliver Giles" <ohw.giles@gmail.com>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date:   Wed, 20 Jan 2021 14:25:34 +1300
Message-Id: <C8NLE0OB4QWG.31VIPNC9SIDPG@oguc>
In-Reply-To: <CAHk-=wiDX9K0aj6mQsQM54yyJTg2fkzME82aSswB2woFGmW81Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Jan 20, 2021 at 9:24 AM NZDT, Linus Torvalds wrote:
> Anyway, anybody willing to test these tty/pipe patches on the loads
> that failed? Oliver?

Writing this from a kernel with those patches in; happily splice()ing
to and from a pty.
