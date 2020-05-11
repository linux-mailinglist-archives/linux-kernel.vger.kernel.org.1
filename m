Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC011CDF06
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 17:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730289AbgEKP34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 11:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730084AbgEKP3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 11:29:51 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48CEC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:29:50 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id s9so8291253eju.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=j2EBovtjYHzHuqz+1wm5uCdWmDSHR/d49IJX3mtpaZU=;
        b=Stdz7+RrZ51VU+h0fnhZk5Gy2uraxyqKnQxPhWgKRwU/V/rZJh/Et00Qty37flUEB6
         UFQqZHi3XWny/uHY7zMBDkCfiVyh+aexgD5BX+8oUY4Igl4t/BDT6XK05IwoABKmQ8Cq
         rTzstvdcZ+/E3MB1MtXiFmRLXEMYoIGD4ts3Vr+WOEzCw05WHTbYyy1NXQP4Vc3QKzRR
         6UjaROwAD462JusLk2wM7OEtq1/yvAKOkJ65hNGvLrypIn7f96jf3opAQq0hBfZYNXkB
         i/qUO3EbZ61jmajFRJfdTDSNDrt2fkj9o/8fmmOCs0FqD3w1yQDhsNLIEVD3RyEmjvhG
         AfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=j2EBovtjYHzHuqz+1wm5uCdWmDSHR/d49IJX3mtpaZU=;
        b=lQlMdN3KGuPzd42wrwUYwsgTZcl915syKPyeIb9KzX6A7iiviumF//1XzuAdcqbIAF
         QM6MXET3KfUGc4zzipRRWNfGiFMGaksJMiqVex0mv9EA5w6SiURHB+zBfwcKC4IeX7mI
         ewkYFjaFiAE7Qz0zIU6VAJko293ObXhtajLhMbtmhN4AsrabNDwvVh1RX3Lh5xZq0aSt
         uhGy/FsEVVGPhzx6HKqPuUkfKehM41PwLoN4qz32/sTeI7ED0fkQKUBaY6H2W07juJ+9
         UZv0gTBvtG5YasPaa81OgqI7jFq3F0He5hs2mMo3j2CIWi7K4hpsCw9hvwDW3mCBOAWJ
         JLEw==
X-Gm-Message-State: AGi0PuY7JC8WGm+iYBk+d+ZJods58traIPRq+ISp4Y2f0SkM57s0Ilfg
        nBy6d9iGG/VdawmgOAgMXaADvhgSKjJEBwL56dA=
X-Google-Smtp-Source: APiQypKg6KvhstZSYbsEDQpuJueCatwrg6pdgSHnyF5NNyM4tSsRfJkVpV/6dHnjRcvKz35DXM6zLddidcHglhQFwVA=
X-Received: by 2002:a17:906:4317:: with SMTP id j23mr13417900ejm.377.1589210989328;
 Mon, 11 May 2020 08:29:49 -0700 (PDT)
MIME-Version: 1.0
Reply-To: ymrzerbo@gmail.com
Received: by 2002:a50:3a06:0:0:0:0:0 with HTTP; Mon, 11 May 2020 08:29:48
 -0700 (PDT)
From:   "Mr.Zerbo Yameogo" <ymrzerbo@gmail.com>
Date:   Mon, 11 May 2020 17:29:48 +0200
X-Google-Sender-Auth: c8Z_0wp_70OAKUrXgMhR-6i-WsU
Message-ID: <CAJTskJV-RbO+mNtQeO-hP358-8LEMJBCpTka=abr9OPUbXUh9w@mail.gmail.com>
Subject: VERY URGENT.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Friend,

           Greetings!

How are you with your family today? I hope both of you are in good
health. Decently I know that this message might meet you in utmost
surprise as we never know each other before. I am Mr. Zerbo Yameogo; a
banker by profession, I need your urgent assist in transferring the
sum of $10.5 Million U.S Dollars into your account. It is 100% risk
free and under this achievement you are entitled to receive 40% of the
total cash. More details will be sent to you on confirmation of your
interest.

Regards;

Mr. Zerbo Yameogo
