Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF9321C9D5
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jul 2020 16:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbgGLOSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jul 2020 10:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728786AbgGLOSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 10:18:46 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0A9C061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 07:18:46 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id cm21so4873046pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 07:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=EdVfURZ+5nZZcnVKH4pRHow2yeyJUb39fEzx1wA8C58=;
        b=MaKZru7H9iLIyI5tDtjRT8MQXjQ+DOuuq8jcKUWYp3Tjtg2q4IgCk+v9aFLf1VhVXv
         XfikPYJMiQxhNuIGEuNynMdXSljPmiWAfHG+GJ4ZIknTaXUEWcJHjPtOhQBjv7PbShvR
         tQW9n2rkXWs99KxvOosgQDrWIVXjmoQGY3TqnKbOF5RRc7yAmVfIxdd9H8UzxMctqgQ1
         7EUJfHNj/aKgV/1BxNsW1d4TxkTE5B3ZsoQ62Ap5FIr6uDtEsPguwgbGIBfBe0xxZW2m
         UJLIhdBdqS9M1cieKwZ06FKtru8LBRftMpzI6raZWbUu1pX0g7eBJa2DxM0qmoVwXj39
         8WMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=EdVfURZ+5nZZcnVKH4pRHow2yeyJUb39fEzx1wA8C58=;
        b=h3wO0kQlKOvyA3PGeqkRRVnU3fFbtyX212/CqCFs58BceNrO7ncZA+4ovf2e8xlcop
         dFxGoUtpBM+BRcgSGMEl4HPqDMRRc9dSkbX+UaMr9BIlyV61E8lXUDTbfVpM5sz7iWOC
         uvGY8vmxQCwmElMDTuM0d7CerGEGY7D0fOgvNbexbsqLwfBP+zCulK+Pv9M7OaukvvWc
         GUAU8u2+CaUNulKXMdgtBoLs78inYT65hFPa9wCpqMvNPoOtlu3EEDJX7YQrEUuz2bcc
         Eol6ad3L7smIvVqRUCn8hDv8Hyb3nFrwDB5h2otqVbKLW0cRIMu2LfWgbGUjLbH2LVAU
         TJPQ==
X-Gm-Message-State: AOAM530dyFKu+JBBEZEw/Q8AAdkwyo1BZxbBDFFqAHAj8e6IZ5INdM0u
        w0IPoOrV66jfPIsY/iik1UzZ4czJWqb79+0tcps=
X-Google-Smtp-Source: ABdhPJzViifji9fOD9+egkZLyYWvZhslXBeAVg0b325nitMLhq57Pb6l7P2GLGjH8DcpLZndjTwp0+zfRMfyD2eZbow=
X-Received: by 2002:a17:902:76c4:: with SMTP id j4mr44443173plt.131.1594563525638;
 Sun, 12 Jul 2020 07:18:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:5d07:0:0:0:0 with HTTP; Sun, 12 Jul 2020 07:18:44
 -0700 (PDT)
Reply-To: ebrimsegun@yandex.com
From:   Refat Ebrima <usmanbanu004@gmail.com>
Date:   Sun, 12 Jul 2020 08:18:44 -0600
Message-ID: <CAO6m5yTQMwoUL_6sVTkRYzy7V576wvFHs7CKWH0AMF5Q8Pa+=w@mail.gmail.com>
Subject: I need your good partnership on this project
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With due respect to your personality and much sincerity of this
purpose, I make this contact with you believing that you can be of
great assistance to me. I'm Mr. Refat Ebrima, from Burkina Faso, I'm
the Chairman of FOREIGN PAYMENTS CONTRACT AWARD COMMITTEE and also I
currently hold the post of Internal Audit Manager of our bank in
Ouagadougou Branch, Please see this as a confidential message and do
not reveal it to another person because it=E2=80=99s a top secret.

We are imposition to reclaim and inherit the sum of US $(38,850,000
Million ) without any trouble, from a dormant account which remains
unclaimed since 7 years the owner died. This is a U.S Dollars account
and the beneficiary died without trace of his family to claim the
fund.

Upon my personal audit investigation into the details of the account,
I find out that the deceased is a foreigner, which makes it possible
for you as a foreigner no matter your country to lay claim on the
balance as the Foreign Business Partner or Extended Relative to the
deceased, provided you are not from here.

Your integrity and trustworthiness will make us succeed without any
risk. Please if you think that the amount is too much to be
transferred into your account, you have the right to ask our bank to
transfer the fund into your account bit by bit after approval or you
double the account. Once this fund is transferred into your account,
we will share the fund accordingly. 45%, for you, 45%, for me, 5%, had
been mapped out for the expense made in this transaction, 5% as a free
will donation to charity and motherless babies homes in both our
countries as sign of breakthrough and more blessings.


If you are interested to help without disappointment or breach of
trust, reply me, so that I will guide you on the proper banking
guidelines to follow for the claim. After the transfer, I will fly to
your country for sharing of funds according to our agreement.
Assurance: Note that this transaction will never in any way harm or
foiled your good post or reputation in your country, because
everything will follow legal process.

I am looking forward to hear from you soonest.
Yours faithfully,
Mr. Refat Ebrima
