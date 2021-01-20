Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660692FDC99
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 23:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733183AbhATW1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 17:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733275AbhATWK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 17:10:26 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3C0C0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 14:09:45 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id a10so19069546ejg.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 14:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=jArWfA3zV/7lnxiWgfjF6a4O9O1fNpc7xFr6lEcByt4=;
        b=vLaDVmzS87B2tpFrzhPBIrcomdjC2KU1+Ib2C9owb1efljvRvdBolEvzTub+gCxjn4
         XjQmc1n/GLBzrhW3t8/3oPOAhrahm+nCvv9ZAaRltyaNrJKP6v+rVGtxP/qRhMjPgo4B
         goLmMKeQm0JCneonKs63ZWiTXZdW7Rm+5wvSAiXoBqPvVtLnMKCJrMRqK9N9yk9SZufp
         wXgSqqAlDYSHBsYPqRtQBb3tnmwzzRf3HrQA6fnjtxxPnCmx6vwezic5WR6yrp4yp4x5
         Hyji+qsVcF6OnHCfFwHZIzT1SL3QRGD2633M9XuyZoTg2l9cDRQmTqlIlr2Xq9M8Hkxz
         CBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=jArWfA3zV/7lnxiWgfjF6a4O9O1fNpc7xFr6lEcByt4=;
        b=NUhslm9PwXBjH6f1zgHkeKqWUZYrR/O5MXaR5pPZXonMMGMoyRpfVjDMtZHFdYgzuH
         Xi0hFhkFgM9o3PjlLwoziBi0+xg1J9uerurNuGtz1YTDxkg44L7AbuZ7U7ChClc7v5/V
         9q5FQ6XQeldvBi6qxc6PnAHh6klaf2NWBeScpDEta3bByL4fMBwvJ+R0ius35orPpkWF
         S3O3k0xaLZ15JR9+2v3b9kwelS1SbN//56M2DClSnsWO8zdC8NSjl8dynzfYRQn1YlcX
         8hQ2gaYVPsHnUAu+zys5cekymb6B26FqCUhf8NdVCTeVoq/jwXcZ5S7Du/HN7KvQzK+j
         wWDw==
X-Gm-Message-State: AOAM532XSY2namkR+ekEd6HX+WrrsL+SWgr3MU2GpYNiZm+lHfXaQ2l3
        qN+E7iYgnjZ5yBvcyb/fdQyadt8Uuma91NTXwk8=
X-Google-Smtp-Source: ABdhPJyPwcNSno35H5kkGf+uh7dtHoKi8X1o5lBWeK1/rH6vz6OZzS4i1S9bwGPggBT8MB9tTQVHdvfP1vn4LfbFTVc=
X-Received: by 2002:a17:907:1b06:: with SMTP id mp6mr7402649ejc.408.1611180584501;
 Wed, 20 Jan 2021 14:09:44 -0800 (PST)
MIME-Version: 1.0
Reply-To: afringawa@gmail.com
Sender: alahmedhassann6@gmail.com
Received: by 2002:a05:6402:40c7:0:0:0:0 with HTTP; Wed, 20 Jan 2021 14:09:43
 -0800 (PST)
From:   Afrin Gawa <alafringawa@gmail.com>
Date:   Wed, 20 Jan 2021 22:09:43 +0000
X-Google-Sender-Auth: 5pYZJWriz8M4vOFCU03oryH8whw
Message-ID: <CAKPjCvxW-2vzOGo9aH73ghnAnJ5fm4s2Smc0fp-4KRd-RQPrcQ@mail.gmail.com>
Subject: With due respect.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I know that this mail will come to you as a surprise as we have never
met before, but need not to worry as I am contacting you independently
of my investigation and no one is informed of this communication. I
need your urgent assistance in transferring the sum of $11,300,000.00
USD immediately to your private account.The money has been here in our
Bank lying dormant for years now without anybody coming for the claim
of it.

I want to release the money to you as the relative to our deceased
customer (the account owner) who died along with his supposed NEXT OF
KIN since 16th October 2005. The Banking laws here does not allow such
money to stay more than 16 years, because the money will be recalled
to the Bank treasury account as an unclaimed fund.

By indicating your interest I will send you the full details on how
the business will be executed.

Please respond urgently and delete if you are not interested.

Best Regards,
Mr. Afrin Gawa
