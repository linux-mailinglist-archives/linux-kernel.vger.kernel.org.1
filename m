Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364841FFA87
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 19:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbgFRRtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 13:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728537AbgFRRtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 13:49:50 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBB5C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 10:49:49 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 9so8322971ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 10:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=H7TfWuJuxniQYZUFW9bvII5Vr1rgNmizaa/XrNQwKLo=;
        b=PEfQf5gPG0tZAf8XwoEA6I3rIEdSoiO8pZUmC28ekKteAWE/CZ6pi0JS9DsYrB0piT
         sRTlgQF/40kRiAZSdZzjNbF/a+mMEouPjXDX6IIUiWX9rPOeykZs+ENh3HD/qLn8l/T2
         duY2whf5ha3m/DCeMHTUVQqjocduvyQXerSYFAt77Msptau40R5KfBj6P5tsxXjMufKX
         fwdnE8chRcvriCtlAls7YgT4FmK8H8uW4Jaxvfm6RfdoV9w3YvwnjDILgTs0Gy4w2Cpj
         WJ0GmyaaQIJcnJqngqxvWW9ELxXl9yFw/UQgr5jBQGwnfr1Jw+17nKLqijl1ou4xH/Qb
         DPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=H7TfWuJuxniQYZUFW9bvII5Vr1rgNmizaa/XrNQwKLo=;
        b=jBizj3BENIYqnY2C1+nIq7ZKe+sQphy/oBqEIeX9NSRf5UD2WfgWWHc3lbVs84vYmv
         6+6+8EjrbEpJNc188T1yhteQuwmsjWzQCTj8QODqCkgfOCaFbCx3d+Gvl5feRHxt+BNB
         3UJiUuPScHFqF8qNrK3oePbzyoMrIy3FCdKaigLvWRxQ/MadBz70PAJPqdkeGpCJv1CE
         hCRHyIhx+exYWAoHORZ7B5cglCL936n5AvX1BK9+tWQyUInSGt7T2YkYlt92YVzqZbl3
         OHfZRe9F6/CrKLXAugRDUuncELFGCJsgaloLZ3yXZ/RKfAyf3lG54rhbVdxRzUDrpuia
         ryzw==
X-Gm-Message-State: AOAM531dcYVYja6VSg3VfNENSRveZDbptB8OVFAYakmeXIPvQB/ZQwnK
        qIexGPaFxaF2nj8YEjPMkrNLFJOjb+T0PzN+IytkqPBi
X-Google-Smtp-Source: ABdhPJxA7Vqa6U+T/a1agvsazT1X8WWTunK8Tu3XgAuCoXIHfYpz+yL2efUijH9+s0ZSc6dRhK68qbxIeXzXwsAyJaI=
X-Received: by 2002:a2e:b005:: with SMTP id y5mr2716204ljk.236.1592502587699;
 Thu, 18 Jun 2020 10:49:47 -0700 (PDT)
MIME-Version: 1.0
From:   "R.F. Burns" <burnsrf@gmail.com>
Date:   Thu, 18 Jun 2020 13:49:37 -0400
Message-ID: <CABG1boOyDJheyNFuxhB0amA3_NH_DtvtZb2BBUtUOCQ01jeCEw@mail.gmail.com>
Subject: PC speaker
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is it possible to write a kernel module which, when loaded, will blow
the PC speaker?
