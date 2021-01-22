Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52DF93005DF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 15:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbhAVOqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 09:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbhAVOpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 09:45:30 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D93DC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 06:44:46 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 3so6806663ljc.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 06:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bd+5w6SAuwGnLG0gTCgFpVNxqx3XZTRIVpDSOCGH/q0=;
        b=nXvgJ52BBj6b9k532t+afc8Iyug6kE2ObVcilm8DvdyuMNvrrFbC/Dt7hS9hdv68BG
         kuw8yCaMhMoNm+n4ykn41OkNnKQKO4pBywYk/1E/Xgs1Nn0hXfTMaNLRInaEbAdtKiSX
         SqPbbrtoayO5sKer7pb/HdZCz0NaBPABXDTmKwm2T41OJ9XqQWmm+t2Ft60T8JpcCgWp
         GIBNR+IR42eex+xw1ehjt/PhtafqBZslwuPrNAUUCdCb5FjnqBSMKYOhb+RmgjmbqKLO
         kJ8xlqJEP+c6ViVG/Fsb9G7DbgRqpKW/lMI/8XXpAoTvZxE94uf5dTzyBxyhYjREXKJn
         E0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bd+5w6SAuwGnLG0gTCgFpVNxqx3XZTRIVpDSOCGH/q0=;
        b=QSfqNoD8ttlI3s9CeCo4GXKJfqJAjYynbjK43FA1EQ9MATgXBEUe9U17qKa04c5iJp
         Q6q6MOsNZDzP7zUz56nIz0crszaSB1bQAwjL5flHg/RR7yUEkDe0tseg1S9QqxUaXd2b
         UhmGSLnjBsEq8sEtZFyvPuq4VmHqxuYlDCMolJ1IG00OEdXyLhnCwb1PdtLrqr0nXORN
         odjJuC6WwV+7mks8TCoyvPoODygxv6opXGA2HnJIIma9hUf5eWMEDrDfK0mfEVg96f6x
         aGo7C3yJo88JaMB8+fNACQKLkZocYKbX67d5CuJqIKwqWPsImhPsk/nw1iUgKsm5Ngvu
         EGwQ==
X-Gm-Message-State: AOAM530+7XVWYPr0Lk4mOC7T38GkavINhj6RzC0gY4FIsb7q2SAQDBcK
        Z5kR/KNiyDvQrychlJREG9B6JjMMxyWtJ6CbFilUYA==
X-Google-Smtp-Source: ABdhPJyY/YxBP3qBv9XqOO1qiLs8Agi4YqAT27RII+GrukDH7p1t+i7XvsugtLNJ1CWcMkNp2f9u2zVVl9K1Rbi2pGQ=
X-Received: by 2002:a2e:780d:: with SMTP id t13mr2491937ljc.144.1611326684827;
 Fri, 22 Jan 2021 06:44:44 -0800 (PST)
MIME-Version: 1.0
References: <20210119181945.2071053-1-paullawrence@google.com> <m2im7pyf9s.wl-thehajime@gmail.com>
In-Reply-To: <m2im7pyf9s.wl-thehajime@gmail.com>
From:   Paul Lawrence <paullawrence@google.com>
Date:   Fri, 22 Jan 2021 06:44:33 -0800
Message-ID: <CAL=UVf7Umq+unpe5=EuaE=3_v6pkA6K=Bnyotgy6jyUVROow6A@mail.gmail.com>
Subject: Re: [PATCH] um: ubd: Fix crash from option parsing
To:     Hajime Tazaki <thehajime@gmail.com>
Cc:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        krisman@collabora.com, chris.obbard@collabora.com,
        linux-um@lists.infradead.org,
        Linux kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This was addressed/fixed by the below patch, though that one doesn't
> the first "file" variable check.

I don't believe the first file variable can in fact be NULL, so my check was
unnecessary. Pleased to see this has been fixed, we can abandon my patch now.

Paul
