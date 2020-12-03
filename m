Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966F62CDE7B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 20:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387818AbgLCTHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 14:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgLCTHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 14:07:06 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C33C061A53
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 11:06:26 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id d18so3261191edt.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 11:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=lTfx3Ov0Wmsj8tR0NT/QpcZwiArs4DzszKRjr4Szd/Q=;
        b=dKMpvSvjin64bvjSls/GmeNtlxNTNhLUS/qnyqcl9tH9z3iW05k8SMeoJXuDUQLjjn
         JIl8/xthS70rNbOCPFJMU0y5LmPeRbdGUsgy5tVcnWGsp5JUwOnMnx72L/x+3P0U0t28
         lMEmMEQhyhdZ9bTP+B9FxWra20Z6nQzWwP62KUxQ5ecQ6ZxDTCIwvMXGcB+3dygS7cpo
         J7HodFdIqnIGiTyxEP0W6Vm9KRqBMPlqSCrEsvEclx2LVKxN1zIyF7fPcciCFCzhxd4N
         Oua3YkuxcAcgyiE6AHl2eulBGIw7lmf2eoU52ySvvhTEGr+00KdbYB95kGH86LyjjDf8
         qqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=lTfx3Ov0Wmsj8tR0NT/QpcZwiArs4DzszKRjr4Szd/Q=;
        b=sepkJm2/30ujFoGWAyW3e6AcBBJ5XTRP2L0bdtwflCYZhY3tzqL3E/OUKmyzMTQwxL
         s65LjHU2Z+VZppWkYU2xKIKj3hEmoEklwbJevjexP/umJlqXhCWhx+pyCIqo68YkU1Mc
         tiRpiMf1Har7rnk+c6u7fBLCVSlHOtjTgX/3tKSM24b2LvgJLqLMakASyAOSBediawMC
         ScFu8EFyFiE+f/2IN1bL5ZZiQmxn8dYBl8BcGxlGJegXGCOEcB+LmKs10C19iz4OY+a5
         IQsKcptcULM191xs8sKKC0yV0ZofgN1bebNhMDxaa5nBCKE66igj3tYHzLXNMKEP6xib
         iEww==
X-Gm-Message-State: AOAM533rZqwrliGdf48r3VJFjmwCVOoqKKWuXFgv24ala6WsWr+JX2lQ
        ann6MzzQUyhr1hyhEuuR2hBZSvXvIHpvNlrRsWs=
X-Google-Smtp-Source: ABdhPJxEuhUWxXXeS0ExRRySrCYRGG3LeefV2ozex+q0LD0fy1ukhJ3ar8jEoDEEHkXPLqxMpNDOhobk1piPoj7D9qc=
X-Received: by 2002:aa7:d54b:: with SMTP id u11mr4204887edr.341.1607022385010;
 Thu, 03 Dec 2020 11:06:25 -0800 (PST)
MIME-Version: 1.0
Reply-To: abderazackzebdani22@gmail.com
Sender: mariaose101@gmail.com
Received: by 2002:a17:906:131a:0:0:0:0 with HTTP; Thu, 3 Dec 2020 11:06:24
 -0800 (PST)
From:   ABDERAZACK ZEBDANI <abderazackzebdani11@gmail.com>
Date:   Thu, 3 Dec 2020 11:06:24 -0800
X-Google-Sender-Auth: 61l9mY1D_UH3bN-_FDT-LnR0Qz4
Message-ID: <CANACK-QoQC7USUrdq1wtU4tBjXuA02+FGn-d4AukOY5hs2dEwg@mail.gmail.com>
Subject: Greetings My Dear Friend,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings My Dear Friend,

Before I introduce myself, I wish to inform you that this letter is
not a hoax mail and I urge you to treat it serious.This letter must
come to you as a big surprise, but I believe it is only a day that
people meet and become great friends and business partners. Please I
want you to read this letter very carefully and I must apologize for
barging this message into your mail box without any formal
introduction due to the urgency and confidentiality of this business
and I know that this message will come to you as a surprise. Please
this is not a joke and I will not like you to joke with it ok,With due
respect to your person and much sincerity of purpose, I make this
contact with you as I believe that you can be of great assistance to
me. My name is Mr.Abderazack zebdani, from Burkina Faso, West Africa.
I work in Bank Of Africa (BOA) as telex manager, please see this as a
confidential message and do not reveal it to another person and let me
know whether you can be of assistance regarding my proposal below
because it is top secret.

I am about to retire from active Banking service to start a new life
but I am skeptical to reveal this particular secret to a stranger. You
must assure me that everything will be handled confidentially because
we are not going to suffer again in life. It has been 10 years now
that most of the greedy African Politicians used our bank to launder
money overseas through the help of their Political advisers. Most of
the funds which they transferred out of the shores of Africa were gold
and oil money that was supposed to have been used to develop the
continent. Their Political advisers always inflated the amounts before
transferring to foreign accounts, so I also used the opportunity to
divert part of the funds hence I am aware that there is no official
trace of how much was transferred as all the accounts used for such
transfers were being closed after transfer. I acted as the Bank
Officer to most of the politicians and when I discovered that they
were using me to succeed in their greedy act; I also cleaned some of
their banking records from the Bank files and no one cared to ask me
because the money was too much for them to control. They laundered
over $5billion Dollars during the process.

Before I send this message to you, I have already diverted
($10.5million Dollars) to an escrow account belonging to no one in the
bank. The bank is anxious now to know who the beneficiary to the funds
is because they have made a lot of profits with the funds. It is more
than Eight years now and most of the politicians are no longer using
our bank to transfer funds overseas. The ($10.5million Dollars) has
been laying waste in our bank and I don=E2=80=99t want to retire from the b=
ank
without transferring the funds to a foreign account to enable me share
the proceeds with the receiver (a foreigner). The money will be shared
60% for me and 40% for you. There is no one coming to ask you about
the funds because I secured everything. I only want you to assist me
by providing a reliable bank account where the funds can be
transferred.

You are not to face any difficulties or legal implications as I am
going to handle the transfer personally. If you are capable of
receiving the funds, do let me know immediately to enable me give you
a detailed information on what to do. For me, I have not stolen the
money from anyone because the other people that took the whole money
did not face any problems. This is my chance to grab my own life
opportunity but you must keep the details of the funds secret to avoid
any leakages as no one in the bank knows about my plans.Please get
back to me if you are interested and capable to handle this project, I
shall intimate you on what to do when I hear from your confirmation
and acceptance.If you are capable of being my trusted associate, do
declare your consent to me I am looking forward to hear from you
immediately for further information. Kindly reply this email (
abderazackzebdani22@gmail.com )
Thanks with my best regards.
Mr.Abderazack zebdani.
Telex Manager
Bank Of Africa (BOA)
Burkina Faso.
