Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1161A2116BD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 01:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgGAXoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 19:44:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbgGAXob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 19:44:31 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2CE2207E8;
        Wed,  1 Jul 2020 23:44:30 +0000 (UTC)
Date:   Wed, 1 Jul 2020 19:44:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     "John Warthog9 Hawley" <warthog9@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [for-next][PATCH 7/8] ktest.pl: Add the log of last test in
 email on failure
Message-ID: <20200701194429.44baae92@oasis.local.home>
In-Reply-To: <20200701231756.619246244@goodmis.org>
References: <20200701231717.757834010@goodmis.org>
        <20200701231756.619246244@goodmis.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Jul 2020 19:17:24 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> +    }
> +
> +    $mail_command =~ s/\$HEADER_FILE/$header_file/g;
>      $mail_command =~ s/\$MAILER/$mailer/g;
>      $mail_command =~ s/\$MAIL_PATH/$mail_path/g;
>      $mail_command =~ s/\$MAILTO/$mailto/g;
>      $mail_command =~ s/\$SUBJECT/$subject/g;
>      $mail_command =~ s/\$MESSAGE/$message/g;
>  
> +	    print ">$mail_command<\n";

Oops, left in this debug print statement.

I nuked it before pushing to linux-next.

-- Steve

>      run_command $mail_command;
>  }
>  
> @@ -4352,6 +4382,11 @@ for (my $i = 1; $i <= $opt{"NUM_TESTS"}; $i++) {
>      }
