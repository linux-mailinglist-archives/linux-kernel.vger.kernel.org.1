Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18DB724FF5F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 15:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgHXN6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 09:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbgHXN6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 09:58:39 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C94C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 06:58:38 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id s2so8728679ioo.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 06:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=QpNNtbUPIEnzzdJdWVbDvtTLPkQ1sOHB0r3DVoWmNtg=;
        b=kpj0V3HHfUh1pHV6NeDlPyWF+m0ZwvpUYuCFAoiS5WM1DUcUzzKcJZ7qjh/rVICo3P
         ddWjH2/Qv5VqP0IEivx1w08DQMgG3cFd90QDA88+DCQJEl/8eYOKysK88StCqaZA/O2A
         GJ1eHvGd6wP00v6g6VBD9sR7Z1JShCdQFl0E/xT3t2Oyd7pL95J/nDvgy0z+iCxwdZwG
         J4wkuMH7yJuNu8q5LeV0mO+rKLREP6bY6bN/clAut4i5YOc8ZS0OUapwrRIhIhGINgha
         6/1HIh2DHUn9xzltveb/gz7eMQd4XN4NnEwD3DBuCd+vXlylReX2L7DQ9toVI9nVnUAZ
         BKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=QpNNtbUPIEnzzdJdWVbDvtTLPkQ1sOHB0r3DVoWmNtg=;
        b=OZpDQCIhFycAXkN0Ng0i+xJSEYoF9k1ntBX56F82VVHZUZ9FZhh0MMmM26UTFqjtaU
         LacycAfrnwAUtvLxuJ/iwftv2yVkZQe+pwdEerTNOqTTZa2Uw5YXC9AZi44sLDFyXKCP
         b6d81bu8q5GKKe1bZ5wBdFTWgQceQYhPUoXzjkK1ORqlTZE0PONXPiBRo7vTBiqfcdaC
         30NFYppdQgVb6RQg482XWmx6n65TmBAMJRd1p2pf4tc3ouxRfJiK0nqi/3B8LnWPm4zB
         X95LqDqAqcg3hzNwaOxsuPV4o1rZ6sSSFCneaObWKvJiEVxneo6wJLv1JbqCDd7O7JVW
         86vA==
X-Gm-Message-State: AOAM531eDrWdiA8Cu4nNSIaA6V1QdbE/KytXPK/cgo/6S/lSP8fVwRhR
        /fwwMDar7iA0PQY0i4lSybfqnNa3BiDjJyj0qxM=
X-Google-Smtp-Source: ABdhPJyIQ5QJ/L+au+wFuttowZIccE0sR9gcVZ1Z7jsryN3Ux2ESV+XTr9rz/er10Rlygp9tRXS/goQ2J5NwRwq1h7Q=
X-Received: by 2002:a5d:888b:: with SMTP id d11mr4878169ioo.188.1598277517952;
 Mon, 24 Aug 2020 06:58:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:b60a:0:0:0:0:0 with HTTP; Mon, 24 Aug 2020 06:58:37
 -0700 (PDT)
Reply-To: susanwilliam1502@citromail.hu
From:   Susan William <victoria.atkins1967@gmail.com>
Date:   Mon, 24 Aug 2020 06:58:37 -0700
Message-ID: <CAJ28r_ZoE5uaOJfxKHFcycPDt=gZdWGKaNmjjqVPxA_Nik+agQ@mail.gmail.com>
Subject: Guten Morgen,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guten Morgen,

  Ich wei=C3=9F, dass Sie =C3=BCberrascht sein werden, wenn Sie diese Mail =
heute
von mir erhalten.
Ich bin Susan William, ich arbeite mit der Royal Bank of Scotland,
Dieser Brief ist sehr privilegiert und erfordert Ihre sofortige
Aufmerksamkeit, da wir einen unserer Kunden verloren haben, der
zuf=C3=A4llig aus Ihrem Land stammt und denselben sicheren Namen bei Ihnen
hat und einen hatte befristete Einzahlung bei unserer Bank vor seinem
Tod. Angesichts Ihrer Nationalit=C3=A4t mit unserem verstorbenen Kunden
Eichinger, .

  Ich m=C3=B6chte Sie der Bank als Beg=C3=BCnstigten des Erbschaftsfonds
vorstellen, und wir beide teilen uns die Mittel zu 50% bis 50%, sobald
das Geld auf Ihr Konto =C3=BCberwiesen wurde.
Ich freue mich auf Ihre sofortige Antwort.

Mit freundlichen Gr=C3=BC=C3=9Fen,
  Susan William.
