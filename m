Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A932A1FA6
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 17:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgKAQvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 11:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbgKAQve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 11:51:34 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D495C0617A6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Nov 2020 08:51:34 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id w1so10613796edv.11
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 08:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=jPnwLjJbhT+4Molc3dOXcTE5ioe28+KSglRtz2Q7Law=;
        b=aOmL1SuZcSy3/fDl4b6+fj/5QwmcoN6FGsZzZYx6Nj2EY+NEM+pi59eIdBQhAopufL
         YhWH9pr3O77N0tkIiLRLxCCRnjJvPcI8ZHX2x6W6ZGZHhHqpj8Il8QAQ6+wRT/LvHc9i
         22/c4ubN5LOrib8V2KeLYYlG51vOCGFTX732WJfSL2wPnfBmEJ107b8e6MQmn304Ob65
         LBAm8Wjr0uHfsMa63Rb/fit7t3rNJyD9+CIt7e1XT8Kv0KkawPZ028Lr1H0VrBvTfFBr
         eZfkIiHdnALBV7X+5cjLORUwGcGG8XsYgy3hn7/Cde1rX/3dZOCc7dwkGgK2a92Q6PF9
         B1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=jPnwLjJbhT+4Molc3dOXcTE5ioe28+KSglRtz2Q7Law=;
        b=VCxNsOQ/uzSiGGF0el0i4mK1sqemAszKwn/TvNdXCOk0uIrvXeHnr4Ml+8I3cfWNuh
         DsMid+8OpFMop2azutRdoqtQ1tQB6kawt/oqqGWOiTBz4eLN83p6zuabkBvV1YFF0DPz
         fdcUCXdb5gATgAxTADgwF/QyYNW4CwreXDI29wG+9rBV4+8PW3zwtvBC1VdmVzYgLaii
         pAo/8a/CUey7d/k6sXZEoOANRtUE1CDR0uun81cQQD8Kb21c99uuXnJfO4srwcGkFsbW
         Jovq+dY49ZVazl5mJ5iYnf0a5Pc4COZ6dMomBxX0Eu6NMHUri36Kp2AIylvqAvImq8aS
         WC6w==
X-Gm-Message-State: AOAM532u1doEfDBP3PDMsN+5z/vu606sDeczkJOEytzA4NURMoDiQ733
        +vko+MiF0QJGClL3GMXrVzXkDojJQk7fM3i0MvCt4DuyELuMgbWj
X-Google-Smtp-Source: ABdhPJxlokI4gM2x2BeutuhrYqgGcnT/Oqxvoo3WZO8/Tvd7d4KElufFkT6oqXGI6U1XX01qKzhxrPW6N3C2YgMYigU=
X-Received: by 2002:aa7:d5d8:: with SMTP id d24mr13355106eds.8.1604249492650;
 Sun, 01 Nov 2020 08:51:32 -0800 (PST)
MIME-Version: 1.0
From:   NASA Jeff <tallboy258@gmail.com>
Date:   Sun, 1 Nov 2020 16:51:20 +0000
Message-ID: <CAN-MDmrpgo=mt696i35K3_2_2inGg6UF=p-tm1HXghtdGryUrg@mail.gmail.com>
Subject: One note on swap
To:     Linux Kml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pages in active areas shouldn=E2=80=99t be swapped out only those in inacti=
ve
areas. So it=E2=80=99s a bit like seminary rock.

Networking may also have scheduling type issues.
My script works well on single/duel CPU systems, for systems with
larger numbers of CPUs I found checking /proc/stat for overall system
load before adjusting the scheduling provided a good solution.
