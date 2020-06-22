Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13465203C56
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 18:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbgFVQRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 12:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729211AbgFVQRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 12:17:50 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DDEC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 09:17:50 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id l24so66658uar.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 09:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=wjunn4+x2QEs4HRrQcozT7INn2DM0lGSHIZkmkDz3T0=;
        b=Zmh0zER2D8UAonzz3aHfSTSuZ2UzR4n/1X65zVMKKdJi78mDCnxnf/OIfVN2Pc7qpX
         w+qH8Ncc0j7QEGI0UTdz/2bqw1EFGaddBfakkAGK1llppsYyESDT3Yygu2TBxRrIVHpT
         /cWvPq14bobR9AnfJJ5O7VBM6Buamv56mDmJmWQoNF3wxaJyPR3nPKd7qWmKha8zR+8A
         GMdlI4d5y71F2iuUhzleEmx0Wt4MO+mcgPp6bRf50pji0r9Yl5EGt9kqbIwoDl3+bzaQ
         gBA58ZRJYj7r5BaikRZ2VJm/L1IDkmvaiCbGajjKpQgGq/lcmcECO9m1GaPMi0XZkSUY
         hzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=wjunn4+x2QEs4HRrQcozT7INn2DM0lGSHIZkmkDz3T0=;
        b=rOAQdrgWMyt1gzafoUOAKguofA1fhTeRg/q5+lD63yI6BDsetjsf5hDkaaQfoqr37P
         bmRRxMTpIzoK/h8HG3ykNBOyS5qqjdQuPbBhd7BUyNxnvKo5VcZ5Dn3N81wjkiCCTlmh
         Oj5J/KPE4YmTIzuuiC6nb5bqUfXL43aPorelyoLSHhDoo+Y2KE5V/LqzKdcDV0L0euT+
         gzYG1/+bPYbnL6XF65rbb5a9pwfNUAkIx/xV42lcqcGlhodvgM2O1uxMfYyqPhL96J+X
         lWp8q2mMOd6AoRRRNnaDv5neBz1KaW6HaMRi+IlA1+y7wRbexMDVR0PKV74uXtHtckbn
         lW1A==
X-Gm-Message-State: AOAM5309/hcBjv1rquGnfJJNMTI2ozTKVBp/K1qImi2DasZ2VkaEoDm+
        Y/prJ9nXZWBlPMcgO1a5Cw/AHbbJ9rgLaYpH9wkarQAC
X-Google-Smtp-Source: ABdhPJwuEmh1bQuB46NvZvuEL4S1bYUpm7/ZXtRErz/hdxswmrkm3TbLBn0kBc1KLd7cQJ4PhhQaZrTrwpZecSGCpfc=
X-Received: by 2002:ab0:78e:: with SMTP id c14mr11606880uaf.81.1592842669430;
 Mon, 22 Jun 2020 09:17:49 -0700 (PDT)
MIME-Version: 1.0
From:   Marc Grondin <marcfgrondin@gmail.com>
Date:   Mon, 22 Jun 2020 13:17:23 -0300
Message-ID: <CAGkKJSFRJ7gJN6mHjy=ujV29pm5MW4DwkemU_vzK_YTZUm3UOg@mail.gmail.com>
Subject: 
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

unsubscribe
