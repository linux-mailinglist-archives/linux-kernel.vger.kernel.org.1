Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670181C8582
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 11:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgEGJQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 05:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgEGJQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 05:16:24 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB824C0610D5
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 02:16:23 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d184so2736528pfd.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 02:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1KzhO/ACECx0/dr+gtbAvw5TnzOduSA4Deti3fiFsj4=;
        b=gd81d8AEVygmBWV4uBrIRxZAPQpzmNitA0DwI6a8WA2ft8QnWGMSpNqYWkC56oUXPI
         8rC9iQWvdUKOUwqNld0DJJIg/ADC88MYJ3+T+wKtc+lU+DgVqudREKvHirbDeRAdQeFj
         Fn4CWdq7Y//hWireUffGioHQuzz8aLjpliAzi6zwheRqMR+MZhb2E/6N4qWmQE2enta7
         YbKNTn8A4UBhoUAnE+B7FTN9h6YdcTBjSCNgByXJHw04EayhIoqX/Ak9fQHExJqmV3jF
         JOjtvQTvqu0F1f9cHxZX3SiFOOmiqmw81dOePciD9dxbOvrWrkG+en8ZRMcHi/JMZbkY
         fvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1KzhO/ACECx0/dr+gtbAvw5TnzOduSA4Deti3fiFsj4=;
        b=ptrws6UO7MAY4ddisEXB/HbfzOitgLgIj/E/3cpftPjZoMn4qzoHV/2MY+yZgHPnUF
         tMLVX+9U6i8UhnG0WU6umUWhDFZEQNbiI1lfBL3YRRBNwfYfm9V/4YM2ADQX/1dRFzmf
         GxxtHdYNep/JAXDvVQmC+u8GG6xiN5c8QfMZb9yRu3fcV/VsQrFDDZ+YLR5XbVM/GP+j
         vez97dAZzCZc75C3FwPBNw6bCyiSePc5HhtFKLGc73ykJl0nOy94xwvfY6oqoIxUmgnU
         gtUZHcS2NpUOPrGFBgW54Vg1zVz0HqLVwaWFque9eRAXDZKNyawVjz/GorRGQwPc48xx
         1mIA==
X-Gm-Message-State: AGi0PubEzW+Atv56vAtwWaSHmlC9WucJGjSCnM/lssbDcq5QfJEEZDqN
        Z9BMIYzpCqnPOUMagaFfij0=
X-Google-Smtp-Source: APiQypIJtHkul5mTY+BSnA1xpHhQ03Lmx87fCT6Ex3npB1S/4ZvMkG814rEtcY8RcbGOdGl8EYTHJw==
X-Received: by 2002:a63:d74a:: with SMTP id w10mr4015942pgi.417.1588842983418;
        Thu, 07 May 2020 02:16:23 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id m8sm660100pjz.27.2020.05.07.02.16.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2020 02:16:23 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        philippe.schenker@toradex.com
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] ARM: dts: stm32: enable stmpe811 on stm32429-disco board
Date:   Thu,  7 May 2020 17:16:10 +0800
Message-Id: <1588842971-20495-1-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <philippe.schenker@toradex.com>
References: <philippe.schenker@toradex.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 3/4] ARM: dts: stm32: enable stmpe811 on stm32429-disco board

remove id, blocks, irq-trigger from the stmpe mfd dts node.
