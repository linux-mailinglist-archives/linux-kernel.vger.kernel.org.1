Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDDF7280333
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 17:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732450AbgJAPuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 11:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732691AbgJAPuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 11:50:07 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A87EC0613E3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 08:50:07 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id p15so3200157qvk.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 08:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=rRjmJekzjKc3btxXuiToGnd/SN56eSyUxlYhyqaToks=;
        b=K1jN1fH+6QSyQCSwaYyF6la2FYeFv8Ehm3qc2QqrGdzq8whyUMy8KU6lGgpquZt7X1
         6NS21k5PamtmrWM3K5mzRD8+BjbUGDONQ/XcdB8kn8b6gokHQ7FpvAzl4E5YTN8lwgdX
         9bbfc9tYAyQI3rTm4eIoH9j2Z7DKXyxDcmTOQ56sbxfpaFonSv+foykXmB7CQcMuDe+g
         2z95gNEQAC7U/KbJM0UmYbyzW7M6OSr6yhee4dhVPG12R+sOiv3VdJDq9x9Ij8EN9Jmx
         jjnj//lae1M11Oswf3yAOZvL3epV1CheUCLufXw715p+IQlDmkH6GlIdYUdBjDWcHo4U
         zvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=rRjmJekzjKc3btxXuiToGnd/SN56eSyUxlYhyqaToks=;
        b=dDuwwlXgAN+dDlKoENE9jQNHV9cR18nNdNxfu4SWBuvWPSjrpcOowutQimCr6JExm+
         lJuh/lCg/Zfs7ZGotYMIP/HArvj6i6X/cp0GjmeIx9eA8j5H/VdrK3Hs1BgvJO4HRlLZ
         P/XbivTSJV/nZ1hUQbW1kKg6inE+cfxQI4fNVB++Kb+kkT9rqgDlmnF97MrYtWz9h+OF
         LVxt+Dzuh7ER2wqK3rWUrZpKtBKmzzcfYmeNT2pVXQpgWxf239UDc1Jxrvs4gI7QZE+L
         orK5yhUUjj0NZDjYYaFL7xvGUfIEJMOvkU4UAaGpVMa5UFBDNvfoX5TvyZOubBYO7pnU
         j3Vg==
X-Gm-Message-State: AOAM531SOu4V11fI2OHtk1qT/ku3cEkE5Wk/doXSSubJIkxC9Lpc8yNQ
        J19Z8H1fYHdLTNzywfSC7LN9m5HAal9TDNe9vwk=
X-Google-Smtp-Source: ABdhPJzVdTbONgEIdwjRoKLAcUaNPj0JwyraqLzQiuU2XycfTvqouD/kQsT2STnZqvcMTcRxjYVb7leQfdtIDfp1Vwg=
X-Received: by 2002:a0c:8246:: with SMTP id h64mr8458069qva.54.1601567406608;
 Thu, 01 Oct 2020 08:50:06 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mrahmedmuzashah@gmail.com
Sender: alimahdi687@gmail.com
Received: by 2002:a0c:efc9:0:0:0:0:0 with HTTP; Thu, 1 Oct 2020 08:50:06 -0700 (PDT)
From:   "Mr.Ahmed Muzashah" <ahmedmuzashah@gmail.com>
Date:   Thu, 1 Oct 2020 16:50:06 +0100
X-Google-Sender-Auth: JnXKtT5WUanYek1j80Tk5hxFK64
Message-ID: <CAJR5xJd_3eZ7ynCwprYqN=HAryAPMz_LkX3xtXg3ohO41tbToQ@mail.gmail.com>
Subject: =?UTF-8?B?U2Now7ZuZW4gVGFn?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sch=C3=B6nen Tag,

Ich bin Mr.Ahmed Muzashah, Account Manager einer Investmentbank hier
in Burkina Faso. In meinem Unternehmen wird seit langem ein
Kontoprojekt von einem Kunden unserer Bank er=C3=B6ffnet. Ich habe die
M=C3=B6glichkeit, den verbleibenden Fonds (15,8 Millionen US-Dollar) zu
=C3=BCbertragen. F=C3=BCnfzehn Millionen Achthunderttausend US-Dollar.

Ich m=C3=B6chte diese Mittel investieren und diese Vereinbarung bei unserer
Bank einreichen. Diese wird im Rahmen einer legitimen Vereinbarung
ausgef=C3=BChrt, die uns vor Gesetzesverst=C3=B6=C3=9Fen sch=C3=BCtzt. Wir =
teilen den
Fonds zu 40% f=C3=BCr Sie, zu 50% f=C3=BCr mich und zu 10%, um eine Basis f=
=C3=BCr
arme Kinder in Ihrem Land zu schaffen. Wenn Sie wirklich an meinem
Vorschlag interessiert sind, erhalten Sie weitere Informationen zur
=C3=9Cberweisung.

Dein,
Mr.Ahmed Muzashah.
