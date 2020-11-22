Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7238C2BFBD6
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 22:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgKVVyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 16:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgKVVys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 16:54:48 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0115C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 13:54:46 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id oq3so20607999ejb.7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 13:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:sender:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=holMzMixu6L4mPkY4KLX0AXrH3B7KLU6Q1+gVZ1hbDo=;
        b=ncFpySwlyDClcG8BDcCu57cQfMMG9BL6+ElukbcYWHSJP2pZ3apEd103fJlmJ1s3Pv
         RdgoNAePWgAZx7FfwXIz10yCH3jaFnTDjPQzS6Fcv2wfNMKmJ/gdgu3TpKFlQVxpaYxH
         Fl1VSJr2ECSWGL0eO8u1Cf4d5rfLXOmpIgpupRXff+V7lNnhYoUvJ7EV1t4TqUQqQU6n
         hjHi+EXyygl8x4AKGiBVaS51N6ayuJLIPLJfNxeMEu6QnRwW6j6G9Q1cJIpmdPPqIRDH
         A4k9eXUEH6qeMgJZnavuowl+l0iRCECGgXia6THd5VMh5Sla23uZpNZiJhiP6Wfqpyun
         ZPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:sender:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=holMzMixu6L4mPkY4KLX0AXrH3B7KLU6Q1+gVZ1hbDo=;
        b=ejga6nhzWQUPLSoSewLPd315hc1ixdy3S6taETUpUk9y6kXB6bEfXW9ywRGu1iZDWD
         4RzmLPBv1ZUAzgbkLGn4TCu638LpCJoW63osGR4VenOJNxF1L8bElVyVluVuX756sqoN
         gc3FKbLstJQAFfoLi2qDx0ogi9QUYWmqcTkD3ZzNlFPDupUx+O7fU/7eJzbrcZaw8I8y
         5nJw5K6NSLl+IGl4oUrKcd5sQY+EpzEbIeTbSvSXtW8O8dfz/7xFHiSZIYojC08S/8wC
         z7YroPFIKduk7nTSjlP2llqss2wxa5LIw2DxNPYCh1D5D6ZxkzmXgjOHwy7sWtlj5ThU
         ybEA==
X-Gm-Message-State: AOAM5317pTdUyRvirosGYjH6nQLOzRnpxuolXJPMmadyk4N7ryyARBbG
        oKTeeiPf5uSq67jfYGmcQg0qilEa4kk=
X-Google-Smtp-Source: ABdhPJyJjimy7q82zhkgE2DBBUnZHD32MzO2w4bdyJdxFjpfgLIo0naT4xafklsC8vMitMn1Ck8uKA==
X-Received: by 2002:a17:906:c357:: with SMTP id ci23mr40126205ejb.311.1606082085561;
        Sun, 22 Nov 2020 13:54:45 -0800 (PST)
Received: from [192.168.43.48] ([197.210.35.67])
        by smtp.gmail.com with ESMTPSA id i19sm3978482ejz.71.2020.11.22.13.54.39
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 22 Nov 2020 13:54:45 -0800 (PST)
Message-ID: <5fbade25.1c69fb81.9b3f2.105d@mx.google.com>
Sender: Lena Torres <ad482289@gmail.com>
From:   Adelina Zeuki <anglicaramose@gmail.com>
X-Google-Original-From: "Adelina Zeuki" <  adelinazeuki@gmail.comm >
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Hello !!
To:     Recipients <adelinazeuki@gmail.comm>
Date:   Sun, 22 Nov 2020 21:54:31 +0000
Reply-To: adelinazeuki@gmail.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi dear,

Can i talk with you ?
