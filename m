Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B32B29BFD9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 18:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1816633AbgJ0RIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 13:08:12 -0400
Received: from mail-vs1-f43.google.com ([209.85.217.43]:37951 "EHLO
        mail-vs1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1816620AbgJ0RIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 13:08:06 -0400
Received: by mail-vs1-f43.google.com with SMTP id b3so1271675vsc.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 10:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=9ODuY0RIvl+FpQKoDSchTRTmCooiEP7E/4lrJUlpPy0=;
        b=KISk5nZcmJPJC943s9pZiGI3iWDYO77UTP56SR2PNSKPM4DZ2nsuyhhXn1EE+xB436
         +yqGkaCYoBPmcS9U3drkDSl2AnWzx7QUx+1sw/G+GrQeX71ETVGS+VyPzqb94F8awPgh
         H7zFX/s8EqG76JCdINn2BYrt2fCDe0pn3hTbwQlN16wTh5pE7d9wpEwlzx5mF9gglHw+
         KLyWCILe1NAW7sAst7+BQDYOnUBoQ6YwzmXrq+guQl5WXg8/NTD0DPP5oLu6/O74FAHf
         ZfdKMijfdcmgHp0kFZkl4M++ozwZgQHAOZHY495nCW6sLTUFVoNKTfXKXJJTiAEhP8dL
         1Rcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9ODuY0RIvl+FpQKoDSchTRTmCooiEP7E/4lrJUlpPy0=;
        b=n40S32SyY/NFwE2mKsJ5TJjMFC6nNctl++igSTFkLssNaccTRMMHj4wu8PkazlLzYu
         FjaiHofgkrHxDYy7fBvWHL9vw68aYh2EB1AG9KBeCRuEWfgknl0dUp8ecFQfLvNxsD/t
         t4W/MCrYCyKXLaiSoPG9e0IDN1yNojdEKLfn3USGYO2Tf3ms1kdFNI8dMEEY3g8V0iMx
         04x44qmmjWpfACf11Q8XfxvorwaZyYL/PdsVA7TpjJVcVyt6Irg2tw/3ZMZI/UaEbO3g
         aBjYN+g11F/kaKmURinPVKF4dnJolBvPaqP89iJy6IWL9m+7fNFi883rxrG9JE9i6dbW
         HnMA==
X-Gm-Message-State: AOAM53101JyPPjQ2qDoA/07NFJv46UvkFMHCoDYfdsA/Yzu6O3DCD6go
        e161YiFjreNY+17DJ7qvjKZh8TJPhmv1ipz4de0eZYAT3lGI3+JC
X-Google-Smtp-Source: ABdhPJxL3XHIMktej+AwHxX5UVravDiILaVL9d5sLrhBNkLYMGJ13Tj42t1w90n6zuphSDxewHz5MT57euKW57zvGh8=
X-Received: by 2002:a67:fbc4:: with SMTP id o4mr2277275vsr.34.1603818484102;
 Tue, 27 Oct 2020 10:08:04 -0700 (PDT)
MIME-Version: 1.0
From:   Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date:   Tue, 27 Oct 2020 22:37:28 +0530
Message-ID: <CAG=yYw=HGvAPQAMQ_hsz43qGkerS=OhJDy3p-OoHfVa-WFEsqw@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/191] 4.14.203-rc1 review
To:     lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello ,

compiled and booted 4.14.203-rc1+ .
dmesg atleast throws issue or issues.

-----x----------------------x------------------------------------------x-------------------------------x-
[    1.822459] ACPI Error: [_SB_.PCI0.RP05.PXSX] Namespace lookup
failure, AE_NOT_FOUND (20170728/dswload2-191)
[    1.822502] ACPI Exception: AE_NOT_FOUND, During name
lookup/catalog (20170728/psobject-251)
[    1.822524] ACPI Error: Method parse/execution failed
\_SB.PCI0.RP04.PXSX, AE_NOT_FOUND (20170728/psparse-548)
[    1.852894] ACPI Error: [_SB_.PCI0.RP09.PXSX] Namespace lookup
failure, AE_NOT_FOUND (20170728/dswload2-191)
[    1.852938] ACPI Exception: AE_NOT_FOUND, During name
lookup/catalog (20170728/psobject-251)
[    1.852959] ACPI Error: Method parse/execution failed
\_SB.PCI0.RP08.PXSX, AE_NOT_FOUND (20170728/psparse-548)
[   19.924198] systemd[1]: Failed to find module 'autofs4'
------------------------------x--------------------------------------x----------------------------------x

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>


-- 
software engineer
rajagiri school of engineering and technology  -  autonomous
