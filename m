Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FA628405C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 22:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbgJEUHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 16:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729424AbgJEUHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 16:07:45 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600F9C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 13:07:45 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id l4so6425772ota.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 13:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HngBJsT2pkNDfP0iYFdvrmf5+8JD+RQ4uR+8/uEH3kU=;
        b=WmWP4LhW5Mtpt3xsgUH8bdwh5aBSFjcbvn/f1V/IRA63gJV/VHv/+fOcvQX7FPNN99
         neZEQfbVWBPvrqP+ktgwqz0GFZXyOFoDqqFOrPZc19kZqVCx5KDDPE5c5BnL/N9jJAQi
         HC5p1KY5XNx/YtvnIk8a19t5pYAoXGXJ7/oTV0wLXZZJd8xaoKa6spDxYJtHDW9IniDz
         fKWuE369yd3jQki9stEpJHnJxJMrjHWzfjdTAqhOorjMWdinMGHesiUNi8dkZLtCjyr7
         Xv/g5dxKRt3k68uKQjgh1BYzotJZ0ATWDVU0NgR4d0jc9MbphxiisILORcEYgzRF0q0b
         CIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HngBJsT2pkNDfP0iYFdvrmf5+8JD+RQ4uR+8/uEH3kU=;
        b=qKXQVOSgKNqRnGha/PXNEL2vyFXJg7QFDmMMJ9oo1NYKiyOUcqNmltGbwGiiP9wgoy
         MnfhKlehdejyVVd9GkLySkcU4cw2n9NPW5qmr/LZfRXmNnmMaV1T2Hs7EfNlibA+ExEH
         dd56SFFKI6UV5d4a+hw6h9kbP3+7ABd6BYFdECLVbgHt0Yx9GnoSasO7a77Lfwdt805B
         5DLzKKf+EcY9zqKNwo5Z7Qx9FxpBnHX00pD1zxGwrJ9dh/RQZwDdp0+fkKL+FIMd4eDE
         X91GYD59lzxCad4jV+63o7Cl+DYvFKqj4z7k5Z+Zp+n/f5aY6CFcXJjHGv80wtYisVeE
         cteA==
X-Gm-Message-State: AOAM533hEZ0Vka1mHUldg8hhgD/ornWXQVorbcpCgZxSuN2mm1uAm+N6
        ScaMywsYiZlT8lZ35aN9anFCu4qqjIMkuhxHkJ35W1+2TKO9BBXj
X-Google-Smtp-Source: ABdhPJxf2RXS+Rz/Sgu1KGCSn4ecBqvlxczn7/w8RO8ORfWBSRAkGO7vfdi4Yg/UmXv85ycO0PkS3Fbh7XWhDbOXWTY=
X-Received: by 2002:a9d:53cc:: with SMTP id i12mr652029oth.215.1601928464464;
 Mon, 05 Oct 2020 13:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <20201005192409.192317-1-dwaipayanray1@gmail.com> <1d8396cb33b33c3d0107ba701b7e597041dfdbc2.camel@perches.com>
In-Reply-To: <1d8396cb33b33c3d0107ba701b7e597041dfdbc2.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Tue, 6 Oct 2020 01:37:22 +0530
Message-ID: <CABJPP5DDmurU9c2qCoJcg7hvwnkYo4LCx+TW6xKG2G23Uf_Cxw@mail.gmail.com>
Subject: Re: [PATCH v3] checkpatch: add new warnings to author signoff checks.
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 6, 2020 at 1:07 AM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2020-10-06 at 00:54 +0530, Dwaipayan Ray wrote:
> > The author signed-off-by checks are currently very vague.
> > Cases like same name or same address are not handled separately.
>
> When you run tests for this, how many mismatches are
> caused by name formatting changes like:
>
> From: "Developer, J. Random" <jrd@bigcorp.com>
> ...
> Signed-off-by: "J. Random Developer" <jrd@bigcorp.com>?
>
> Should these differences generate a warning?
>

Hi,
I ran my tests on non merge commits between v5.7 and v5.8.

There were a total of 250 NO_AUTHOR_SIGN_OFF Warnings

203 of these were email address mismatches.
32 of these were name mismatches.

So for the name mismatches, the typical cases are like:

'From: tannerlove <tannerlove@google.com>' !=3D 'Signed-off-by: Tanner
Love <tannerlove@google.com>'
'From: "=E6=9C=B1=E7=81=BF=E7=81=BF" <zhucancan@vivo.com>' !=3D 'Signed-off=
-by: zhucancan
<zhucancan@vivo.com>'
'From: Yuval Basson <ybason@marvell.com>' !=3D 'Signed-off-by: Yuval
Bason <ybason@marvell.com>'
'From: allen <allen.chen@ite.com.tw>' !=3D 'Signed-off-by: Allen Chen
<allen.chen@ite.com.tw>'

I didn't find the exact formatting change you mentioned in my commit range.
But I did find something like:

'From: "Paul A. Clarke" <pc@us.ibm.com>' !=3D 'Signed-off-by: Paul
Clarke <pc@us.ibm.com>'

So it's like some have parts of their names removed, some have language
conflicts, and yet some have well different spellings, or initials,
etc. It's like
a wide variety of things happening here.

I think considering these, it should be warned about, and let people know
that there might be something wrong going on.

What do you think?

Thanks,
Dwaipayan.
