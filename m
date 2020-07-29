Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC71231C66
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 12:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgG2KBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 06:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgG2KBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 06:01:19 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFE6C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 03:01:19 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id k23so23838736iom.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 03:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Zv3B6Y/B3VY6FrYdYo1vmGhb0SIiMokCkNyxDZgxgT4=;
        b=SYWojBDovc43SMQiUTjMNcg5wYk9EsylL7n8TCQH/J3VEDesQ101kzPzD7mZfLZnVh
         lq1uRdRUlSJztGmxAZoLDe8UCtkxPkoKyGOotAm/f9vVYlSrgduVDCeqgDabV7IyLFhk
         HCw6exc+q1gbNi7Ti7t2kyb5SBGA0VAftfa1ndkXmmLCJzfN1nMlHZFVXPYuvfO5JN0C
         hPhz4WDIWt9MlDIBmdFsR0EwebVTRC43+neVG3Eor3VqPIGpLnI/blTyg5N/TiCZqK8N
         7UTEsUPpl8/nLk9UGzqIjXfCJHzlDbLP+zr9dM2tjJEF1nuuhMhDPab7eNGIrA665jkT
         xqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=Zv3B6Y/B3VY6FrYdYo1vmGhb0SIiMokCkNyxDZgxgT4=;
        b=cpcbQ5j7RJ5lZu/dCP74Cffsrjg6Ng+/IUsqLVd95VrMZ4fvApCPjo4v0uJNNNOBPL
         GIi2yB5Tlx+NF3xQsPFaJszx0UTTgmugCb0g4hvla+iJTW/NzVmcHk3p2MsfCbH39bOi
         jJn/lkDeSbmxm1H2aBtcyyZ5A+ypN8rmZvjwdALl6XgNuvl03LFghtDvENgikNio7MYp
         Yl7j4cWewmWHAYUhF6U/s7bsAkb8d65Vq19xfsy8j4Lxo5UE9nVol4cgY/O2ObVJIkYE
         U1wJYnuBzXY27kmtpqxF9cU4GS1GIq2pEWsJavBYoWBeXhJfL+LGN26QT0wc3AdTfz22
         neCg==
X-Gm-Message-State: AOAM533YGo9vNz92/HnlR4Y245EQTy8Cw4gXdf3SlXe7vcnvLpoolWC+
        egn/JKK+pq0U4X7rdQrKqDpp3QfYSRlQkBvH7oE=
X-Google-Smtp-Source: ABdhPJz14KfKGl9d9X0sc1aDsU6HlLuAuy7aOR1ro18PzR5t+FuZDSMndPAgPTFml+JtHdwuirC5g3zSEiCRdS07BH4=
X-Received: by 2002:a05:6638:164e:: with SMTP id a14mr13723751jat.18.1596016878059;
 Wed, 29 Jul 2020 03:01:18 -0700 (PDT)
MIME-Version: 1.0
Reply-To: dr.allisonneher@yandex.com
Received: by 2002:a92:ba54:0:0:0:0:0 with HTTP; Wed, 29 Jul 2020 03:01:16
 -0700 (PDT)
From:   "Dr. Allison Neher" <dr.allisonneher@gmail.com>
Date:   Wed, 29 Jul 2020 03:01:16 -0700
X-Google-Sender-Auth: imJFclg0qORjMqgQb8S8kVSMIwQ
Message-ID: <CAH1yJ8Rc8EiM3eB=AE1U3__LDpyBsFaGBpT+uAW+=hKbZvPafA@mail.gmail.com>
Subject: PLEASE RESPOND VERY URGENTLY
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Friend,

With due respect, i have decided to contact you on a business
transaction that will be beneficial to both of us. At the bank last
account and auditing evaluation, my staffs came across an old account
which was being maintained by a foreign client who we learn was among
the deceased passengers of motor accident on November.2003, the
deceased was unable to run this account since his death. The account
has remained dormant without the knowledge of his family since it was
put in a safe deposit account in the bank for future investment by the
client.

Since his demise, even the members of his family haven't applied for
claims over this fund and it has been in the safe deposit account
until i discovered that it cannot be claimed since our client is a
foreign national and we are sure that he has no next of kin here to
file claims over the money. As the director of the department, this
discovery was brought to my office so as to decide what is to be done;
I decided to seek ways through which to transfer this money out of the
bank and out of the country too.

The total amount in the account is (18.6 million) with my positions as
a staff of this bank, i am handicapped because i cannot operate
foreign accounts and cannot lay benefice claim over this money. The
client was a foreign national and you will only be asked to act as his
next of kin and i will supply you with all the necessary information
and bank data to assist you in being able to transfer this money to
any bank of your choice where this money could be transferred into.

The total sum will be shared as follows: 50% for me, 50% for you, and
expenses incidental occur during the transfer will be incur by both of
us. The transfer is risk free on both sides hence you are going to
follow my instruction till the fund transfer to your account. Since I
work in this bank that is why you should be confident in the success
of this transaction because you will be updated with information=E2=80=99s =
as
at when desired.

I will wish you to keep this transaction secret and confidential as I
am hoping to retire with my share of this money at the end of
transaction which will be when this money is safety in your account. I
will then come over to your country for sharing according to the
previously agreed percentages. You might even have to advise me on
possibilities of investment in your country or elsewhere of our
choice. May god help you to help me to a restive retirement?

(1) Your full name..............
(2) Your age:................
(3) Sex:.....................
(4) Your telephone number:.................
(5) Your occupation:.....................
(6) Your country:.....................

Yours sincerely,
Dr. Allison Neher
+226 58779013
