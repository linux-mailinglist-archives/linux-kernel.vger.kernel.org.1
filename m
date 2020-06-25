Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE8420A324
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 18:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406392AbgFYQhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 12:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404184AbgFYQhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 12:37:39 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB480C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:37:38 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id w6so6589024ejq.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VwAmIR6VLB+YcfnphtZyHLrRryQdawnk8xblq99lNpw=;
        b=gQSZ2Bq3lC6LnQf8Wk4oi/jk/M+PtWAEGUIJCVTZFd0D2FgW/K9QRB/MBUeqIapMP2
         /sptmreyARmDtm0x+VJyFlWrnJYPyMZ+ttEIz90lDqC5HgCFT7Sa9J3PkEw6zc2vC6E9
         LZMTXIezWvX1sXa4VXd8MP2OhCyn8sVufJvL5pg0Gib0H4HumVaCUqZfoHQcodemyQNQ
         FiZLQPHjwFUJN9aXTdGSO4hsSNX5D1r6fI6himeDy/+J6yaGZvSH11f6o4IEAsmu2xj4
         /W6b1OyjVmrA4rD/MjrQk5RJWIBms9dkbPYUyyQcZZEtNkcrBTBFDMNX2nYasOUGJwtU
         zacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VwAmIR6VLB+YcfnphtZyHLrRryQdawnk8xblq99lNpw=;
        b=Jahg5X9ktvErf6avxkveWMgCk4OfC/MEd0m+mOyYcCxnL5gah2HMhDXX5KvmDeTET7
         PRM3Q/iQoRhRNkKk4lvbF9iUPEBWm4jE/+dxJbAed1qCoSqclIgYWlT7CwUv9EMg4PmA
         AHkAizOZcsd5IYNhsZO4p6SVwpqzchRWFlbNMjrLljCzF9NqPstSsrZrbRMraksoyr0t
         Wt54rQDxEiTqJGyT9C1Cb2uimLOWjjRPtp63FaFZlsmvqCiuZMOiNE9tMXkKZmJ6mvyu
         EdXtoDAzESfwqrfAZN9gGFBLs/BJkztzgMg+AxzUIrHU7cCH4scOUVwsdoSS/nU6n5Tt
         fT3Q==
X-Gm-Message-State: AOAM53013bJJ95pj9uU0g5l2apt3bvw/1bidlp7hZCqnmkwSqi33RP2J
        M6EV//r/WdxcLHGz8HldORk=
X-Google-Smtp-Source: ABdhPJxvrRXlwZ2mp6kReJp3W3P2fYlzehlk3EWz7EpOv4/Pv2iiKdP8/uQ7IcJvK12FBnscwEgQwQ==
X-Received: by 2002:a17:906:fcc1:: with SMTP id qx1mr12562143ejb.379.1593103057718;
        Thu, 25 Jun 2020 09:37:37 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7f9:7600:7032:f41f:3b67:e84b])
        by smtp.gmail.com with ESMTPSA id u60sm11052049edc.59.2020.06.25.09.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 09:37:36 -0700 (PDT)
Date:   Thu, 25 Jun 2020 18:37:35 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        David Brazdil <dbrazdil@google.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, android-kvm@google.com
Subject: Re: [PATCH v3 08/15] arm64: kvm: Split hyp/switch.c to VHE/nVHE
Message-ID: <20200625163735.yneq6lzpmfst2pak@ltop.local>
References: <20200618122537.9625-9-dbrazdil@google.com>
 <202006251244.YDWclRrq%lkp@intel.com>
 <d807e83db1f1052378b6998f683e4617@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d807e83db1f1052378b6998f683e4617@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 09:16:03AM +0100, Marc Zyngier wrote:
> 
> I really wish we could turn these warnings off. They don't add much.
> Or is there an annotation we could stick on the function (something
> like __called_from_asm_please_leave_me_alone springs to mind...)?

There is: '__visible'.

-- Luc
