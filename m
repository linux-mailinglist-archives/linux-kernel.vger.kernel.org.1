Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD282D2E38
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 16:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbgLHP2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 10:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729910AbgLHP2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 10:28:25 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AB9C061749
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 07:27:44 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id h16so6660730edt.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 07:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=YMax7HXKrIBHqsRJBxpKIHMa/O+tINsTtd7XKbDtC80=;
        b=DtsHviAdDeIWnaFQR/4iMHT4WVx4haBzizrp65eLK/AnaXH7J4YB1pzEPzS/O4vBJ9
         Ebx6M9XiWuOL/U7iIAGYO+wfAoq/4klaGiMh1pXBl1pixubuHYrpNvK/uWUnf0hS0URq
         ySMz8xCld6VG5hEkBYMVtMW826QsTEbIBZnadVhE4I9GT3bvKuaajEPg8Jk2+eph5mnE
         WOsdO1kx/M11A7HzISfnkT59GxWUdXyd0jnqKkPnpcswkGdYb3CvbnlP12EJQRf+rR6f
         XSZOcdULNin1YhpOoYoae/XiMYWKmqRqpAHp3DKy4Ry06r1PfvYl6tGdP3bVUmGU6fxl
         wcqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=YMax7HXKrIBHqsRJBxpKIHMa/O+tINsTtd7XKbDtC80=;
        b=A/IVbYJSHNm/yzmNSjURZoYYLs5na/0Pte/ZSKr5Q8zqDypW35t1TwVMKvoBzv6qvR
         dEZjXLIqBsNFTUDGK8M8R+KG2Ne6y9AVf8Ty0QGdHIz8fxNN7f7z1IPRu2T9z4gry+AZ
         FKLhfgrFs/cs5++jZhVjRMQunzDNgAszTKmg0B2YlhNobMbgF7W7LYSDq9elIn7mWSpb
         7+zp9iHNorJ8afIbrrG0FqqBVdxEzSu/I0vz6J1Ei98KobXEdIDsk4BRjwy5qxVkeFPR
         HbpkVylkOusfhErKhvBU/KtxBb3rkpvvy1+Ty9fOTppogM6hckFvuqLnfBBsZmJ3+zO8
         zk0Q==
X-Gm-Message-State: AOAM532bJzVcYQV0N8PQZaiFrFSJxXhcuqbC1M/itnlvu3sQkhMrqv+S
        B5qsaeStfnq9WNLoaPP14dZMZHUvuHlic/Rgj8I=
X-Google-Smtp-Source: ABdhPJwXWrPfdESaIWcsQRA4cQAaN7jFbp2ZxDXBjIpRPebP2gryuT8mhnAYFjdLtQ5FMeEQA2LCe1ouIQwOYykRykM=
X-Received: by 2002:a50:e00b:: with SMTP id e11mr25129724edl.303.1607441263700;
 Tue, 08 Dec 2020 07:27:43 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a54:2f52:0:0:0:0:0 with HTTP; Tue, 8 Dec 2020 07:27:43 -0800 (PST)
Reply-To: stephenbordeaux@yahoo.com
From:   Stephen Bordeaux <jafar78546@gmail.com>
Date:   Tue, 8 Dec 2020 16:27:43 +0100
Message-ID: <CAP_crS=sr6eR_ApH58+AH506vOLCbSupkotw9PRgynP0zkOhkg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sch=C3=B6nen Tag
Ich bin Anthony Calder, Anwalt aus Togo. Ich habe Sie bez=C3=BCglich des
Nachlasses des verstorbenen Dr. Edwin-Fonds in H=C3=B6he von 8,5 Millionen
US-Dollar kontaktiert, der auf Ihr Konto zur=C3=BCckgef=C3=BChrt werden sol=
l.
Dar=C3=BCber hinaus m=C3=B6chte ich, dass Sie bei dieser Transaktion vertra=
ulich
antworten.
Anthony Calder
