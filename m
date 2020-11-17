Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC712B6D3E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 19:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbgKQSYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 13:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730650AbgKQSYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 13:24:19 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C856C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:24:19 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id p12so25390183ljc.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jvUf4J0DFW1w2WtJ3V6+jniQAPhY7yyvFEspsD/tJmg=;
        b=PEkPOajtdsc4vIPnzM9bVRVqYkht1WKu9HytymEE8l1JV5LOIEPq4BZ4U++e/c0KUw
         gwT0H1upKqxmypmrqpI9U3ggwpq1tCugR4BokqmJbZUSWy5UvZT3kY0Gec7Lk89ev35b
         zSUKO3Tk9zzocvLF3Nc/ui5aJ3U1f2I/TBi5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jvUf4J0DFW1w2WtJ3V6+jniQAPhY7yyvFEspsD/tJmg=;
        b=Re/fMtaZNI8fgk4+RQHXCmsPnuG4y5r0Tetiy97tKPB3rQJF7b3SkAvWfLve4jbtH0
         6nPpnWbcmR26rpqRsEXcZV+4OyReOgBAFOHfL4ZzzNIObhdplwdFDShBWqJ0YROAxLT2
         bHpNVJeGwDxSWZxtjKsOWpxbhWOfJPC+l98mVBg9MPDHs56PoK3iYs8xQY17mquqi+ip
         aHOzOGw+z5DsVRnLjFIscqMtZq7tgFuHMIG7Tjs5vbfK1V8YWl5Gb3Wv8kd7t4/sjE7N
         d5yxeHATsFIeMOuvUIgSWK1/EIvwGjrPQLh9n4PK7zBIx1Ztv+ysHPmDuTeKoARCunQq
         fwEg==
X-Gm-Message-State: AOAM5327ozwfvgYoghtHChi1vTWncse6V+wI20IFJSMg4GM9pXV/Q/cl
        TsB6H4RQ9vtDHa9D+FaiBkfTSke92XF/sw==
X-Google-Smtp-Source: ABdhPJxEV9gzPJAUSm8I0Zgdapn/CggviGCKfDmney/E3Q20+ZhhZSZZGJh99DXjD0R3rspxz0i+Vw==
X-Received: by 2002:a2e:9a88:: with SMTP id p8mr2410833lji.266.1605637456898;
        Tue, 17 Nov 2020 10:24:16 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id h10sm1171028lfc.18.2020.11.17.10.24.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 10:24:15 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id 74so31449695lfo.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:24:15 -0800 (PST)
X-Received: by 2002:a19:c301:: with SMTP id t1mr2049940lff.105.1605637454918;
 Tue, 17 Nov 2020 10:24:14 -0800 (PST)
MIME-Version: 1.0
References: <20201113080132.16591-1-roberto.sassu@huawei.com>
 <20201114111057.GA16415@infradead.org> <0fd0fb3360194d909ba48f13220f9302@huawei.com>
 <20201116162202.GA15010@infradead.org> <c556508437ffc10d3873fe25cbbba3484ca574df.camel@linux.ibm.com>
 <CAHk-=wiso=-Fhe2m042CfBNUGhoVB1Pry14DF64uUgztHVOW0g@mail.gmail.com>
 <20201116174127.GA4578@infradead.org> <CAHk-=wjd0RNthZQTLVsnK_d9SFYH0rug2tkezLLB0J-YZzVC+Q@mail.gmail.com>
 <3f8cc7c9462353ac2eef58e39beee079bdd9c7b4.camel@linux.ibm.com>
In-Reply-To: <3f8cc7c9462353ac2eef58e39beee079bdd9c7b4.camel@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Nov 2020 10:23:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wih-ibNUxeiKpuKrw3Rd2=QEAZ8zgRWt_CORAjbZykRWQ@mail.gmail.com>
Message-ID: <CAHk-=wih-ibNUxeiKpuKrw3Rd2=QEAZ8zgRWt_CORAjbZykRWQ@mail.gmail.com>
Subject: Re: [RESEND][PATCH] ima: Set and clear FMODE_CAN_READ in ima_calc_file_hash()
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 10:35 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> We need to differentiate between signed files, which by definition are
> immutable, and those that are mutable.  Appending to a mutable file,
> for example, would result in the file hash not being updated.
> Subsequent reads would fail.

Why would that require any reading of the file at all AT WRITE TIME?

Don't do it. Really.

When opening the file write-only, you just invalidate the hash. It
doesn't matter anyway - you're only writing.

Later on, when reading, only at that point does the hash matter, and
then you can do the verification.

Although honestly, I don't even see the point. You know the hash won't
match, if you wrote to the file.

           Linus
