Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B67B29FCAD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 05:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgJ3EUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 00:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgJ3EUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 00:20:33 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F6CC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 21:20:33 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id b15so6170316iod.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 21:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:date:subject:message-id
         :to;
        bh=uoULYXfmfsYvZeTl2rSN1/TVjepk39OejLyjg4WnFN0=;
        b=XzkbfPEjbJluRFcgAD0P+lgIJVUfuPLtnp37IhlJhszpPjOKrOXFEnWjSGe9Gwsmn+
         X/lZ7NJamO/rvQUNfEej4WOZjo+yIpxfxwBlRgXBZSGXHJOsXlY6DlHi8AEgdK26IlP7
         YAKmuVxgNQ96Kp/9m2DZRJLL+KlC1atrguBc1gMAIzCDfzOVh3UBB7TLybUxJhDSV88V
         t0U/GSy2HucnJomAJD2aW7gq3urzNuBVOy5woA1ox5yHzC8rmJIVm7E94VEunATI81YK
         bHxaxRGdFv0XAwtIgyPl0b/ZY5wtTU57kHjAUl3Gaba9wFJy9NpyGTgH210UGrRW9sai
         jxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version:date
         :subject:message-id:to;
        bh=uoULYXfmfsYvZeTl2rSN1/TVjepk39OejLyjg4WnFN0=;
        b=a6teMiSGRx/bUj5LvcFddp26xgPkydyTNbDd4o10Dietg8NK3I240qs+/WF63ps006
         8hdpU8eH9F9oQWdNQ4P3Ke8Lh+rg1GO2KT20d4oVN4kK0nSAJA3N1gFwQDocq5PR6WFC
         +z72dXWCbut9wQCt3BKubObNywpy9l1IBb4nrDjLUOQ2PiMGNTZgQ1vGDp9zHK6G11kn
         H3SvuSgRSjmYWqqE/EtzfgsBzc/D3H5VSJ6Aln+VjwEbXT1t6ds+luvqDHNbMa6pX7wx
         /bsGE5yXh9cEPmjAMf5SKe//cegfYr8Sk2MA4EMjoDvgOgNQJv1cWGchmCIfNzpJmTEp
         39Fw==
X-Gm-Message-State: AOAM533Ql4YzAbcASD07aFVlDcWroIGZc5Wpa5S0653zhn4QCg/MpQek
        jWXGVCM3Cvm+goFbD1DzJiD/MglsUWc=
X-Google-Smtp-Source: ABdhPJymr10ktMT0DsNy33l16iY9/vU2GtfzBxBkEd57en9dthBX+PfriBk1mbiE9ylxeSHvlQ0opQ==
X-Received: by 2002:a05:6638:102c:: with SMTP id n12mr523501jan.87.1604031632521;
        Thu, 29 Oct 2020 21:20:32 -0700 (PDT)
Received: from [10.200.10.20] ([114.141.194.12])
        by smtp.gmail.com with ESMTPSA id f77sm4564212ilf.40.2020.10.29.21.20.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2020 21:20:31 -0700 (PDT)
From:   NASA Jeff <tallboy258@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Date:   Fri, 30 Oct 2020 04:20:05 +0000
Subject: One note 
Message-Id: <3511E8B5-E3FD-44DD-B2CF-B22236F6AF18@gmail.com>
To:     linux-kernel@vger.kernel.org
X-Mailer: iPhone Mail (16G201)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pages in active areas shouldn=E2=80=99t be swapped out only those in inactiv=
e areas. So it=E2=80=99s a bit like seminary rock.

Sent from my iPhone=
