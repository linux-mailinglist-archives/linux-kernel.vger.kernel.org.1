Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB9E1D8BB2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 01:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgERXk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 19:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgERXk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 19:40:56 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06A8C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 16:40:55 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id c24so9700834qtw.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 16:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=zMf1ol6Clx/k/hSOSDJAbQyv0BhYSmliFHitxb6ckWM=;
        b=ip33ZZH/9/QhByuelU3lGSogSNC2h0LADRIuYH4izAW+MhNrwXIYtncF7oikbjInbX
         1thxu4Ut2GVlcTbeXJtFtiIoTPOGDBAPTNGfYEq9h4azrNyCUrejLuHLdNpBp4a/A6bG
         RsdECybopTCzcVmi+JoerOS4ExMJlDRCLqs0gjm9t3H/R/yC3WiudsVnNhtsU/1E+QlI
         RM+ibluYndMZPhVoKOulcQiUz9V2sgWwIgU4DoWNU29inBXKY02RUCO7cgS49aaanVTV
         fIM+cgTxlAu2DBOM7uk+0BTprAbKO1bcvEx5adhBTOljUBKsQkBZp1iPCpfVDYkvsaHa
         LW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=zMf1ol6Clx/k/hSOSDJAbQyv0BhYSmliFHitxb6ckWM=;
        b=Xl718UfociivXHe3OywNJ/QjMAbTPpRftDlkodG5PuX0Uz0ldi0s9YsBGJpD90P1g9
         s+VQr89V2xUL9IJjExNtUXME1FnGumVmdGqBgfW/GESAwhiew4pS/MwD7gVyl5NS4U9G
         i6IePxDgbY7FHEcBtGSfmWO95gVXOyIWQ+V93sbxIT1QusDB/0CX9P60eqJfo37swgvN
         Oe0JDM9VGQBRxZbZHjXHquoOat73Y7soHbhclJ3f54aQrvHruQNfWA/Xw4gEmtZxITCb
         vAlczuE1s6NEJ/UIpRNl1ypcgjcuMfdkQcQxfs9YckLxfAWg5QQChaPzvNOY/ghtoNeC
         O+cw==
X-Gm-Message-State: AOAM533ZYvIsglv4fIdrqBwaiIK1rcKYs5kF08bV4HOqTzJTJr7gKGr5
        9nQ0GXQZpRrTzPXhkWjAx0Q=
X-Google-Smtp-Source: ABdhPJyltryGJ6c3kimgdcUgCfpPCrfF2NxTlErvLk3Xgbc3+ac2FewlFOGHQ4w+J9/R/oj5a3hFrg==
X-Received: by 2002:ac8:6f28:: with SMTP id i8mr9669126qtv.163.1589845255162;
        Mon, 18 May 2020 16:40:55 -0700 (PDT)
Received: from LeoBras (177-131-65-239.dynamic.desktop.com.br. [177.131.65.239])
        by smtp.gmail.com with ESMTPSA id l15sm10630241qti.83.2020.05.18.16.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 16:40:54 -0700 (PDT)
Message-ID: <2ccc819dba70152bc57cf375a8f792a28a3c433f.camel@gmail.com>
Subject: Re: [PATCH v5 2/2] powerpc/rtas: Implement reentrant rtas call
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Daniel Axtens <dja@axtens.net>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nadav Amit <namit@vmware.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 18 May 2020 20:40:34 -0300
In-Reply-To: <1589614523.yfijifo1n6.astroid@bobo.none>
References: <20200516052137.175881-1-leobras.c@gmail.com>
         <20200516052137.175881-3-leobras.c@gmail.com>
         <1589614523.yfijifo1n6.astroid@bobo.none>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-05-16 at 17:36 +1000, Nicholas Piggin wrote:
> Good, I think this should work as you want now. Can you allocate it like 
> lppacas? Put it under PSERIES (and in the paca) and check for !HV?

Sure, I will do that. 

> Oh and while there, could you prefix the name with rtas_?

Sure, replacing reentrant_args with rtas_args_reentrant.

>
> Thanks,
> Nick

Thank you for the feedback!
Leonardo Bras

