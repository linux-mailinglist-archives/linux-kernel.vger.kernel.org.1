Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8C52FA86E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 19:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407280AbhARSNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 13:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436516AbhARRdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:33:01 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE61C061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 09:32:20 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id f1so4365194edr.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 09:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to;
        bh=6vAyG8pXFCuEbUKT8BIvGb7R3aJ4T0NPUnVXzESIxHc=;
        b=QXRuZpBXpqrFxO/chyv2+dB+c47XTIclxtXw6kmf12/WHOKF5AryNZj2STzybhbNtx
         uKwtjtTNYFKizRpKbOTD7YbvWTM3CEAZAkbQJvp0+CMs9Mzj8iao8gztEXMjDFwZvk5P
         x0xMMg//XE+c0QEkfpm9T8YeX3ygtHTeLOy5KWiayFK5FJNzlZcvAN1Pfsz4K4bymOFH
         zhYJDlfwuSQgihF+lIZhueUe9Y7wF72DWAECJ1dYsGMoWgqNLSu1Hio4aJUYY3jr7XxL
         r7MJSk8VRnPmfn+GqXkY7IKQG5r/aMQGcQK92DansG9BnGrIL6EjxTUaQwwb28JTZSE1
         OQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=6vAyG8pXFCuEbUKT8BIvGb7R3aJ4T0NPUnVXzESIxHc=;
        b=jJdFr8OT5BfQf7nqO+oxsjGtNQxb0KGXo72YZFR942ZRAcKDz1lR0dw2b65CKwVSXf
         X7GkaynaGLa81ezN0/bDT9KM6HA2GJGWhsbhKOSAaQhjZa+tqirWkqzBfnmgFY5PrJOI
         hcplPtA5TdrSvm1FMOAdRODb3IpfTvIY33oQDc35NpYMwTq3wv+jXi1g+arzF45MVWD5
         lpPBrCLJPXgXwyBCugDCEqfy4pnuAKm4q8IJVqXoy8I0D1Gc+lg1AXazetjiDJNeQWfr
         XkoB5vtgk8EFxFP9E6KZ+9CyZqWnh/w98R35Vw70QvsjaKUo7CDpVIiErcPAetK/Ld2B
         lXlA==
X-Gm-Message-State: AOAM530jcua8BjJcf0hjC/Vj7vN9ymITtolyurhCydQ4k3NPhOBtllj4
        8ksW0JHEIKJPrmbMOIUJTIkCqi5v4tWYPO0L8p/izdjuLkn77MlqcmZ0Aw==
X-Google-Smtp-Source: ABdhPJyPV5lw6G4g8/CufBd67PJI6FKTz0fFpDss80tcba48zm/yi6qvQVj8TGxvJQI7j+E3J/cDPtq+oIdI7GQyke4vWXzffw7+sg==
MIME-Version: 1.0
X-Received: by 2002:aa7:c9cf:: with SMTP id i15mr421901edt.296.1610991139711;
 Mon, 18 Jan 2021 09:32:19 -0800 (PST)
X-Google-Address-Confirmation: XLvhqVpmXrBffS56SV0hmuG76O0
Date:   Mon, 18 Jan 2021 17:32:19 +0000
Message-ID: <CAAbjFO5oB=p0CpY8uTdZNPg3PdBgAEejckMiXhyw83b1WWaTTw@mail.gmail.com>
Subject: (#99427480) Gmail Forwarding Confirmation - Receive Mail from bjs3141@gmail.com
From:   Gmail Team <forwarding-noreply@google.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bjs3141@gmail.com has requested to automatically forward mail to your email
address linux-kernel@vger.kernel.org.
Confirmation code: 99427480

To allow bjs3141@gmail.com to automatically forward mail to your address,
please click the link below to confirm the request:

https://mail-settings.google.com/mail/vf-%5BANGjdJ9hkvVgkNjxohK3G_smiGacACYcwk1mNYesZgMNvYW4BzAjq2dMIquordeb4zBjMpesxyn8hzstTPmJ-tFlIvYJQmvthZrjyyD0XQ%5D-Zra73ESu8vcr1vUZT9u1ya-8wUA

If you click the link and it appears to be broken, please copy and paste it
into a new browser window. If you aren't able to access the link, you
can send the confirmation code
99427480 to bjs3141@gmail.com.

Thanks for using Gmail!

Sincerely,

The Gmail Team

If you do not approve of this request, no further action is required.
bjs3141@gmail.com cannot automatically forward messages to your email address
unless you confirm the request by clicking the link above. If you accidentally
clicked the link, but you do not want to allow bjs3141@gmail.com to
automatically forward messages to your address, click this link to cancel this
verification:
https://mail-settings.google.com/mail/uf-%5BANGjdJ-5d9aZBg-1gmgZZhr6kOPH_6fP491j8UNFfGKqAlgULEukePGe0svsjArkaLH75AgucvoiWvUPhfe-gjgpfBSdtc5PPluFixypzQ%5D-Zra73ESu8vcr1vUZT9u1ya-8wUA

To learn more about why you might have received this message, please
visit: http://support.google.com/mail/bin/answer.py?answer=184973.

Please do not respond to this message. If you'd like to contact the
Google.com Team, please log in to your account and click 'Help' at
the top of any page. Then, click 'Contact Us' along the bottom of the
Help Center.
