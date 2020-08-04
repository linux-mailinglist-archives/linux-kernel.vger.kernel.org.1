Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3AF123BBB7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 16:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729063AbgHDOGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 10:06:44 -0400
Received: from mail.efficios.com ([167.114.26.124]:50186 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728295AbgHDN67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 09:58:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id F12202D769B;
        Tue,  4 Aug 2020 09:58:04 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id tybkGbFx1mbR; Tue,  4 Aug 2020 09:58:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C4D352D769A;
        Tue,  4 Aug 2020 09:58:04 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C4D352D769A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1596549484;
        bh=AUi6J/jcrFKZsqRhlt0jBDKzpRYliEYDWAHQ4jjfWlI=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=euaJCyVJbJLqKBH6hnnIdxVOsCxZTScYHvEFyj03H17w8gMHu9E5Rchv87jIcktlH
         bvL/k2XWKhOaVWFlWmlkwPMqBDzqtYrjUMpN3aPv/McSghszEDkxTfyDoWlHEPYouP
         Uz7Kj9z7MD/kovIcRzz4XaX1XnFAk0iA8oYN/0c6j6h+/ejdbsqzkQHKXCC9N1EJf3
         oMhc/WBrT9WuTjTdCEQKJjnaBpoXiHFeRx+vvNhdM4pg5AxnR+vGyyiivkY+Iu8jis
         UfKZHZvJrVBMdX/7BHxOZ9LguBfsLzcO/3Eu33QPjmtZdTm1KxsOnNpBQTf8MaHFtv
         RGPeafTT0s5qA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Tb47rpLt7jds; Tue,  4 Aug 2020 09:58:04 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id B7E2C2D7698;
        Tue,  4 Aug 2020 09:58:04 -0400 (EDT)
Date:   Tue, 4 Aug 2020 09:58:04 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     lttng-dev <lttng-dev@lists.lttng.org>
Cc:     Diamon discuss <diamon-discuss@lists.linuxfoundation.org>,
        linux-trace-users <linux-trace-users@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Message-ID: <1934497535.39785.1596549484739.JavaMail.zimbra@efficios.com>
Subject: [RELEASE] LTTng-modules 2.11.5 and 2.12.2 (Linux kernel tracer)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3955 (ZimbraWebClient - FF79 (Linux)/8.8.15_GA_3953)
Thread-Index: gVJiywk8vItU5cAGlFsCDw6PIbTDhQ==
Thread-Topic: LTTng-modules 2.11.5 and 2.12.2 (Linux kernel tracer)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The releases 2.11.5 and 2.12.2 of LTTng-modules are bug fix releases, which
also add support for the recently released Linux kernel 5.8.

The LTTng modules provide Linux kernel tracing capability to the LTTng
tracer toolset.

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
