Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A82C11A38BC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 19:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgDIRO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 13:14:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39510 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgDIRO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 13:14:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id g32so5257661pgb.6;
        Thu, 09 Apr 2020 10:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qABVumhieKrODuYVGr+5avf5kX3MFltmBukZWdasrJA=;
        b=KQOphPMznphyoGYIkuOBFaK7lS1caRVnAjSOCj1o3XXzL25YoQx47gLuRzS4KoQMB6
         uFSPipgTodee39w/yS8gQKrDugkI9yPwClPKKEMZDb3eoZLXkTqjHv8uBy3aGBMwQKJZ
         82SWo6adAZkCdV/Nc3NrQLMMv5OVRkYZGq5G0nv3j08rVdEm1P4IkDwxA5Oxcwfk+3pP
         0Y3Ji7pWRBmR4717x8UMy7yORtw9HPhrVtgQL43WJ2Uq4PypyMhKOwnOcl9O7XJYILol
         /xAKPLQYnLRueFMQmD4u/c3iFA4Qp46bbxb8I5BCGKmHV5lmWlyBFMPLVPJagN34J/B5
         moFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qABVumhieKrODuYVGr+5avf5kX3MFltmBukZWdasrJA=;
        b=LumiNC7OLTNjgNWy6h7Z+ZNyxuw+NTX5hkJHDyvBFXAjgwZivZ3FlISiUvI4PT0mnR
         rSZX6IhvmUoEGkDOzWHVCNr29L/ljXpPP2MWaL7ImmxZZPl4sDFHcGs4s+Vbb8bPZiMx
         0G9K3xjtzb68Qo2EPi5v7QfkVNRJ/h8mDIatIDD65Wod48mnelv3xAKkNvPtE/cJ5Rty
         Qi/liaOfUjO1R/xqoQA5rpsOSxU6w12RSmAz7IffXzf53HcsISWcdh7wCRXpH3lr+ydm
         bq7CMB947MLyG7EcE71gWLLGpMg+0Tq7IqfNMlWcAxx/oPtDMpv6Kgo/fg+q/7etlUoQ
         c6Og==
X-Gm-Message-State: AGi0PuY1n2c6AAG7G3rCSc1q4/32sfpsPmtcdA/eVN2cJKYcuDiz5FVA
        dkhhEI0Jp6vWMBthY5XDIKU=
X-Google-Smtp-Source: APiQypINADUHV8gYck9k/TH3dnArn3EZzgu0Jzkvj/9quYGuYenA0XnNfZzwHaIVO7tHVCjQ0YtwPQ==
X-Received: by 2002:aa7:949d:: with SMTP id z29mr561451pfk.111.1586452497196;
        Thu, 09 Apr 2020 10:14:57 -0700 (PDT)
Received: from localhost.localdomain ([2408:821b:3c17:6960:4f7:54ff:5542:dca3])
        by smtp.gmail.com with ESMTPSA id i2sm19715030pfr.203.2020.04.09.10.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 10:14:56 -0700 (PDT)
From:   youling257 <youling257@gmail.com>
To:     abhishekpandit@chromium.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, davem@davemloft.net,
        johan.hedberg@gmail.com, linux-kernel@vger.kernel.org,
        kuba@kernel.org, hdegoede@redhat.com,
        youling257 <youling257@gmail.com>
Subject: Re: [RFC PATCH v6 0/5] Bluetooth: Handle system suspend gracefully
Date:   Fri, 10 Apr 2020 01:14:29 +0800
Message-Id: <20200409171429.5990-1-youling257@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200311155404.209990-1-abhishekpandit@chromium.org>
References: <20200311155404.209990-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series cause a suspend problem on BYT/CHT device, https://bugzilla.kernel.org/show_bug.cgi?id=207169
