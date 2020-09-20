Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD1C27140B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 13:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgITLx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 07:53:56 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:15784 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726250AbgITLx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 07:53:56 -0400
X-IronPort-AV: E=Sophos;i="5.77,282,1596492000"; 
   d="scan'208";a="468611353"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2020 13:53:31 +0200
Date:   Sun, 20 Sep 2020 13:53:31 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     joe@perches.com, apw@canonical.com
cc:     linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk
Subject: outside repository fatal error
Message-ID: <alpine.DEB.2.22.394.2009201346560.2966@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit bcf4271d4bc3 ("checkpatch: allow not using -f with files that
are in git") in linux-next seems to cause checkpatch to fail on a file
containing a patch if that file is not in the directory containing the
Linux kernel.  Is that intentional?

thanks,
julia
