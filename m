Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269712836D0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 15:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgJENo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 09:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgJENoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 09:44:54 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE81C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 06:44:53 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id 67so6727215ybt.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 06:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=mDU3NjQ+wfGR1xHjzGrV7JHcfcQ06j1rR+mmDUoauFo=;
        b=dy9XLUbpbjVsQBNufbdqJNVl8sibATNndAALv81ErhyD9xzCE9pRMnmtfOohrV9y2M
         nIWX/jRyCE0cF0NYmTcorVymYzvvcbNQpolnEL4c21YQjwQ5M+/Oj7e/19hC9RUUU8Bi
         rWkfjbiYobNBR/n8PsVZ1rnBeKVm3vxVHcyYy4yW4K1FksjEOSylLg/pUvx/DORVf+q3
         IieiUF51kGeCLjAmY31d9zwRE1t4d2nM4HHl5ZiU4pxpa3EhXDxfVBOG1f6zsBrLUDeR
         NyPjvc1KignAm0qTFhnN5YYt8fSm0eIapCuXJWlhaVm7iMX3UaKqFTnS+XS6FP7ImpfH
         AxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=mDU3NjQ+wfGR1xHjzGrV7JHcfcQ06j1rR+mmDUoauFo=;
        b=GWrlUJoztGS9WXkw/bV7r/snmgFfif+APl8Zgvl2f3A5kkWjgJ1SktNF70ITKhC5jH
         kUtNkpJLaWH4EmwDFruzox0wRhzYGFr9u8yieOsd8lYuGtpcSsdsjrqu3MvqOf2b/T6C
         cMdrIkJoZTPsHC2Eq7jyJsmMIawCtmhMo90DelJDHADP5naRnvwts5fOgEkiBICTFnGY
         BXoeLCZMG7nT50TzTSbM2V6W8JAhdLllSB07LU+ybdrtFoXuVl/rfsnKr7zzWcLHdTyB
         8VGxR5m/ggmqDeroimZN2uita8G5Zc1N5M/T6ZzkQmRHFbI5U1kfsLnpZM1Bt0yTQlVv
         sGyg==
X-Gm-Message-State: AOAM531fKPa2oAb863odfG343z1zor/gBRcdzG+0wezHlvH0McWIs08y
        Y1BGVH9UGi6AzA/dveT9x8rFueWvFZtlOhdNR1U=
X-Google-Smtp-Source: ABdhPJw96JLB4HoAYr+mRXANpkazyJpy9vTEYNG1M1Knkq/VH9/YM/7ehDnh8uR4gd9zEFAqQfstJVgnlwsWmK1B55g=
X-Received: by 2002:a25:de49:: with SMTP id v70mr19168899ybg.367.1601905493249;
 Mon, 05 Oct 2020 06:44:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:491:0:0:0:0:0 with HTTP; Mon, 5 Oct 2020 06:44:52 -0700 (PDT)
From:   james duke <jm.jamesduke.dk09@gmail.com>
Date:   Mon, 5 Oct 2020 13:44:52 +0000
Message-ID: <CAFNA5BOcOkLyHMyoOvyem0Z2dq9s_9U514Y4EGFrux5ctpUv_A@mail.gmail.com>
Subject: =?UTF-8?B?15TXkNedINen15nXkdec16og15DXqiDXlNeU15XXk9ei15Qg15TXp9eV15PXnteqINep?=
        =?UTF-8?B?15zXmT8=?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Best wish
