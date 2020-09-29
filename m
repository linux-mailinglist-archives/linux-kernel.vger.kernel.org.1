Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A6827DB50
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 00:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgI2WCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 18:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbgI2WCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 18:02:37 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3721C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 15:02:36 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id md22so4360525pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 15:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lj6wRGM9Tdc2xfVB9HHjXprQqeJjKQWn9/2bOPM/4/8=;
        b=wBcfuUDPvHn3Rja5AVt9J82WEe30BNhkKF0KkkHyhJKHsQ7OlQJbrUB7e1PMGJsy5s
         pUsxb78MweqhlcrR7fwqWA+19yhgHA9nak4fhgSuXFlh8CBW8ElWsT+SvwGtlEVKq+ST
         V/rTJwc+HsLMaM9+ltZ00zRmuvvchBK+azyKIo9vO6q+5uHAClLWkOWE8ArvlGbNtxun
         SskUR7OuofeYzvv9gan4Rxue7bSqtFTR4C9elxcosIQMp6KnwBGPu6sWGeKzRdbms2my
         Z/layxkdPRjwOXh8YhDFqGuFCJiNnT8cqqtVjFowJyeULsBTq+1buM6cIPbb9Nx8Ppxt
         hdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lj6wRGM9Tdc2xfVB9HHjXprQqeJjKQWn9/2bOPM/4/8=;
        b=C+6x6dkif4L23Ds4ZApHI3mXgsIcn/RK8jHDaVBJ5aFRqrBIYfLbMeJf2PLUCiScmh
         pi+UvffLPCd0JzP6siYw2phQPrsyDxrY3Z5q3ZBf777L6gdsB2MM7ei54M1Z3NpvBJkU
         IyWFOBKq0aYtMa4nfXXtUZ0zbZUnjei0vRPbBgFdRsAr1IWu10zBonsTJqGFkbdGhnCl
         IZwE7BdcZAAHCcoAK9MN/5Vm+QqZNuURaRY/jlL30emVtsfk+T0r7xK70o9OGafw01xz
         cXd8SE5ltKpBU886LXjtwt5jTLQ3cvQPTEDqT6vSr+0IrBVWPwaIMxyPRXeX0PteR8XO
         Ls+w==
X-Gm-Message-State: AOAM530G18JebGbdBpBP/FJvvd0jzZN+XF2hCXuGd94+8wGupEMYzVYY
        i7IqrxRnrxbQOHpHb10sYgJh+bWUVJ8S63KYEoIu63UgRVU=
X-Google-Smtp-Source: ABdhPJzL2GO2sgioy3lrewCrQVOAn34+ntuBnhCn8r6OhaQa0zd7nHuLsZEOEL7Z0BKiYWv0EjjqJfBje5W30vI6XXw=
X-Received: by 2002:a17:90a:c17:: with SMTP id 23mr5680357pjs.127.1601416956019;
 Tue, 29 Sep 2020 15:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601410890.git.zanussi@kernel.org> <a296c3ead3da5f55e29eda2f40d69847d745071b.1601410890.git.zanussi@kernel.org>
In-Reply-To: <a296c3ead3da5f55e29eda2f40d69847d745071b.1601410890.git.zanussi@kernel.org>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 29 Sep 2020 15:01:59 -0700
Message-ID: <CAJHvVch+VA4oHafZzf5HRAwW321hKJKsTYC8mr_89yGjnUx8aw@mail.gmail.com>
Subject: Re: [PATCH 3/3] tracing: Add support for dynamic strings to synthetic events
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 1:33 PM Tom Zanussi <zanussi@kernel.org> wrote:
>
> Currently, sythetic events only support static string fields such as:
>
>   # echo 'test_latency u64 lat; char somename[32]' > /sys/kernel/debug/tracing/synthetic_events
>
> Which is fine, but wastes a lot of space in the event.
>
> It also prevents the most commonly-defined strings in the existing
> trace events e.g. those defined using __string(), from being passed to
> synthetic events via the trace() action.
>
> With this change, synthetic events with dynamic fields can be defined:
>
>   # echo 'test_latency u64 lat; char somename[]' > /sys/kernel/debug/tracing/synthetic_events
>
> And the trace() action can be used to generate events using either
> dynamic or static strings:
>
>   # echo 'hist:keys=name:lat=common_timestamp.usecs-$ts0:onmatch(sys.event).test_latency($lat,name)' > /sys/kernel/debug/tracing/events
>
> The synthetic event dynamic strings are implemented in the same way as
> the existing __data_loc strings and appear as such in the format file.
>
> Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> ---
>  Documentation/trace/events.rst    |  15 ++-
>  Documentation/trace/histogram.rst |  18 ++++
>  kernel/trace/trace_events_hist.c  |   9 ++
>  kernel/trace/trace_events_synth.c | 157 ++++++++++++++++++++++++++----
>  kernel/trace/trace_synth.h        |   4 +
>  5 files changed, 181 insertions(+), 22 deletions(-)
>
> diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
> index f792b1959a33..2a5aa48eff6c 100644
> --- a/Documentation/trace/events.rst
> +++ b/Documentation/trace/events.rst
> @@ -589,8 +589,19 @@ name::
>          { .type = "int",                .name = "my_int_field" },
>    };
>
> -See synth_field_size() for available types. If field_name contains [n]
> -the field is considered to be an array.
> +See synth_field_size() for available types.
> +
> +If field_name contains [n], the field is considered to be a static array.
> +
> +If field_names contains[] (no subscript), the field is considered to
> +be a dynamic array, which will only take as much space in the event as
> +is required to hold the array.
> +
> +Because space for an event is reserved before assigning field values
> +to the event, using dynamic arrays implies that the piecewise
> +in-kernel API described below can't be used with dynamic arrays.  The
> +other non-piecewise in-kernel APIs can, however, be used with dynamic
> +arrays.
>
>  If the event is created from within a module, a pointer to the module
>  must be passed to synth_event_create().  This will ensure that the
> diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
> index 8408670d0328..b573604deabd 100644
> --- a/Documentation/trace/histogram.rst
> +++ b/Documentation/trace/histogram.rst
> @@ -1776,6 +1776,24 @@ consisting of the name of the new event along with one or more
>  variables and their types, which can be any valid field type,
>  separated by semicolons, to the tracing/synthetic_events file.
>
> +See synth_field_size() for available types.
> +
> +If field_name contains [n], the field is considered to be a static array.
> +
> +If field_names contains[] (no subscript), the field is considered to
> +be a dynamic array, which will only take as much space in the event as
> +is required to hold the array.
> +
> +A string field can be specified using either the static notation:
> +
> +  char name[32];
> +
> +Or the dynamic:
> +
> +  char name[];
> +
> +The size limit for either is 256.
> +
>  For instance, the following creates a new event named 'wakeup_latency'
>  with 3 fields: lat, pid, and prio.  Each of those fields is simply a
>  variable reference to a variable on another event::
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 1b2ef6490229..ee6b27c82350 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -3279,6 +3279,15 @@ static int check_synth_field(struct synth_event *event,
>
>         field = event->fields[field_pos];
>
> +       /*
> +        * A dynamic string synth field can accept static or
> +        * dynamic. A static string synth field can only accept a
> +        * same-sized static string, which is checked for later.
> +        */
> +       if (strstr(hist_field->type, "char[") && field->is_string
> +           && field->is_dynamic)
> +               return 0;
> +
>         if (strcmp(field->type, hist_field->type) != 0) {
>                 if (field->size != hist_field->size ||
>                     field->is_signed != hist_field->is_signed)
> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
> index 6e7282c7b530..00c6c61038d1 100644
> --- a/kernel/trace/trace_events_synth.c
> +++ b/kernel/trace/trace_events_synth.c
> @@ -88,7 +88,7 @@ static int synth_event_define_fields(struct trace_event_call *call)
>
>                 event->fields[i]->offset = n_u64;
>
> -               if (event->fields[i]->is_string) {
> +               if (event->fields[i]->is_string && !event->fields[i]->is_dynamic) {
>                         offset += STR_VAR_LEN_MAX;
>                         n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
>                 } else {
> @@ -139,6 +139,9 @@ static int synth_field_string_size(char *type)
>         if (len > 3)
>                 return -EINVAL;
>
> +       if (len == 0)
> +               return 0; /* variable-length string */
> +
>         strncpy(buf, start, len);
>         buf[len] = '\0';
>
> @@ -290,10 +293,25 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
>
>                 /* parameter values */
>                 if (se->fields[i]->is_string) {
> -                       trace_seq_printf(s, print_fmt, se->fields[i]->name,
> -                                        (char *)&entry->fields[n_u64],
> -                                        i == se->n_fields - 1 ? "" : " ");
> -                       n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
> +                       if (se->fields[i]->is_dynamic) {
> +                               u32 offset, data_offset;
> +                               char *str_field;
> +
> +                               offset = (u32)entry->fields[n_u64];
> +                               data_offset = offset & 0xffff;
> +
> +                               str_field = (char *)entry + data_offset;

Is it better to re-use __get_str from include/trace/trace_events.h
instead of writing this out directly?

> +
> +                               trace_seq_printf(s, print_fmt, se->fields[i]->name,
> +                                                str_field,
> +                                                i == se->n_fields - 1 ? "" : " ");
> +                               n_u64++;
> +                       } else {
> +                               trace_seq_printf(s, print_fmt, se->fields[i]->name,
> +                                                (char *)&entry->fields[n_u64],
> +                                                i == se->n_fields - 1 ? "" : " ");
> +                               n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
> +                       }
>                 } else {
>                         struct trace_print_flags __flags[] = {
>                             __def_gfpflag_names, {-1, NULL} };
> @@ -325,16 +343,52 @@ static struct trace_event_functions synth_event_funcs = {
>         .trace          = print_synth_event
>  };
>
> +static unsigned int trace_string(struct synth_trace_event *entry,
> +                                struct synth_event *event,
> +                                char *str_val,
> +                                bool is_dynamic,
> +                                unsigned int data_size,
> +                                unsigned int *n_u64)
> +{
> +       unsigned int len = 0;
> +       char *str_field;
> +
> +       if (is_dynamic) {
> +               u32 data_offset;
> +
> +               data_offset = offsetof(typeof(*entry), fields);
> +               data_offset += event->n_u64 * sizeof(u64);
> +               data_offset += data_size;
> +
> +               str_field = (char *)entry + data_offset;
> +
> +               len = strlen(str_val) + 1;
> +               strscpy(str_field, str_val, len);
> +
> +               data_offset |= len << 16;
> +               *(u32 *)&entry->fields[*n_u64] = data_offset;

Similar thing here, is it possible to reuse __dynamic_array or __string?

> +
> +               (*n_u64)++;
> +       } else {
> +               str_field = (char *)&entry->fields[*n_u64];
> +
> +               strscpy(str_field, str_val, STR_VAR_LEN_MAX);
> +               (*n_u64) += STR_VAR_LEN_MAX / sizeof(u64);
> +       }
> +
> +       return len;
> +}
> +
>  static notrace void trace_event_raw_event_synth(void *__data,
>                                                 u64 *var_ref_vals,
>                                                 unsigned int *var_ref_idx)
>  {
> +       unsigned int i, n_u64, val_idx, len, data_size = 0;
>         struct trace_event_file *trace_file = __data;
>         struct synth_trace_event *entry;
>         struct trace_event_buffer fbuffer;
>         struct trace_buffer *buffer;
>         struct synth_event *event;
> -       unsigned int i, n_u64, val_idx;
>         int fields_size = 0;
>
>         event = trace_file->event_call->data;
> @@ -344,6 +398,18 @@ static notrace void trace_event_raw_event_synth(void *__data,
>
>         fields_size = event->n_u64 * sizeof(u64);
>
> +       for (i = 0; i < event->n_dynamic_fields; i++) {
> +               unsigned int field_pos = event->dynamic_fields[i]->field_pos;
> +               char *str_val;
> +
> +               val_idx = var_ref_idx[field_pos];
> +               str_val = (char *)(long)var_ref_vals[val_idx];
> +
> +               len = strlen(str_val) + 1;
> +
> +               fields_size += len;
> +       }
> +
>         /*
>          * Avoid ring buffer recursion detection, as this event
>          * is being performed within another event.
> @@ -360,10 +426,11 @@ static notrace void trace_event_raw_event_synth(void *__data,
>                 val_idx = var_ref_idx[i];
>                 if (event->fields[i]->is_string) {
>                         char *str_val = (char *)(long)var_ref_vals[val_idx];
> -                       char *str_field = (char *)&entry->fields[n_u64];
>
> -                       strscpy(str_field, str_val, STR_VAR_LEN_MAX);
> -                       n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
> +                       len = trace_string(entry, event, str_val,
> +                                          event->fields[i]->is_dynamic,
> +                                          data_size, &n_u64);
> +                       data_size += len; /* only dynamic string increments */
>                 } else {
>                         struct synth_field *field = event->fields[i];
>                         u64 val = var_ref_vals[val_idx];
> @@ -525,6 +592,27 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
>         if (size < 0) {
>                 ret = -EINVAL;
>                 goto free;
> +       } else if (size == 0) {
> +               if (synth_field_is_string(field->type)) {
> +                       char *type;
> +
> +                       type = kzalloc(sizeof("__data_loc ") + strlen(field->type) + 1, GFP_KERNEL);
> +                       if (!type) {
> +                               ret = -ENOMEM;
> +                               goto free;
> +                       }
> +
> +                       strcat(type, "__data_loc ");
> +                       strcat(type, field->type);
> +                       kfree(field->type);
> +                       field->type = type;
> +
> +                       field->is_dynamic = true;
> +                       size = sizeof(u64);
> +               } else {
> +                       ret = -EINVAL;
> +                       goto free;
> +               }
>         }
>         field->size = size;
>
> @@ -532,7 +620,6 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
>                 field->is_string = true;
>
>         field->is_signed = synth_field_signed(field->type);
> -
>   out:
>         return field;
>   free:
> @@ -663,6 +750,7 @@ static void free_synth_event(struct synth_event *event)
>                 free_synth_field(event->fields[i]);
>
>         kfree(event->fields);
> +       kfree(event->dynamic_fields);
>         kfree(event->name);
>         kfree(event->class.system);
>         free_synth_tracepoint(event->tp);
> @@ -673,8 +761,8 @@ static void free_synth_event(struct synth_event *event)
>  static struct synth_event *alloc_synth_event(const char *name, int n_fields,
>                                              struct synth_field **fields)
>  {
> +       unsigned int i, j, n_dynamic_fields = 0;
>         struct synth_event *event;
> -       unsigned int i;
>
>         event = kzalloc(sizeof(*event), GFP_KERNEL);
>         if (!event) {
> @@ -696,11 +784,33 @@ static struct synth_event *alloc_synth_event(const char *name, int n_fields,
>                 goto out;
>         }
>
> +       for (i = 0; i < n_fields; i++)
> +               if (fields[i]->is_dynamic)
> +                       n_dynamic_fields++;
> +
> +       if (n_dynamic_fields) {
> +               event->dynamic_fields = kcalloc(n_dynamic_fields,
> +                                               sizeof(*event->dynamic_fields),
> +                                               GFP_KERNEL);
> +               if (!event->dynamic_fields) {
> +                       free_synth_event(event);
> +                       event = ERR_PTR(-ENOMEM);
> +                       goto out;
> +               }
> +       }
> +
>         dyn_event_init(&event->devent, &synth_event_ops);
>
> -       for (i = 0; i < n_fields; i++)
> +       for (i = 0, j = 0; i < n_fields; i++) {
>                 event->fields[i] = fields[i];
>
> +               if (fields[i]->is_dynamic) {
> +                       event->dynamic_fields[j] = fields[i];
> +                       event->dynamic_fields[j]->field_pos = i;
> +                       event->dynamic_fields[j++] = fields[i];
> +                       event->n_dynamic_fields++;
> +               }
> +       }
>         event->n_fields = n_fields;
>   out:
>         return event;
> @@ -1276,8 +1386,8 @@ __synth_event_trace_end(struct synth_event_trace_state *trace_state)
>   */
>  int synth_event_trace(struct trace_event_file *file, unsigned int n_vals, ...)
>  {
> +       unsigned int i, n_u64, len, data_size = 0;
>         struct synth_event_trace_state state;
> -       unsigned int i, n_u64;
>         va_list args;
>         int ret;
>
> @@ -1301,10 +1411,11 @@ int synth_event_trace(struct trace_event_file *file, unsigned int n_vals, ...)
>
>                 if (state.event->fields[i]->is_string) {
>                         char *str_val = (char *)(long)val;
> -                       char *str_field = (char *)&state.entry->fields[n_u64];
>
> -                       strscpy(str_field, str_val, STR_VAR_LEN_MAX);
> -                       n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
> +                       len = trace_string(state.entry, state.event, str_val,
> +                                          state.event->fields[i]->is_dynamic,
> +                                          data_size, &n_u64);
> +                       data_size += len; /* only dynamic string increments */
>                 } else {
>                         struct synth_field *field = state.event->fields[i];
>
> @@ -1357,8 +1468,8 @@ EXPORT_SYMBOL_GPL(synth_event_trace);
>  int synth_event_trace_array(struct trace_event_file *file, u64 *vals,
>                             unsigned int n_vals)
>  {
> +       unsigned int i, n_u64, len, data_size = 0;
>         struct synth_event_trace_state state;
> -       unsigned int i, n_u64;
>         int ret;
>
>         ret = __synth_event_trace_start(file, &state);
> @@ -1376,10 +1487,11 @@ int synth_event_trace_array(struct trace_event_file *file, u64 *vals,
>         for (i = 0, n_u64 = 0; i < state.event->n_fields; i++) {
>                 if (state.event->fields[i]->is_string) {
>                         char *str_val = (char *)(long)vals[i];
> -                       char *str_field = (char *)&state.entry->fields[n_u64];
>
> -                       strscpy(str_field, str_val, STR_VAR_LEN_MAX);
> -                       n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
> +                       len = trace_string(state.entry, state.event, str_val,
> +                                          state.event->fields[i]->is_dynamic,
> +                                          data_size, &n_u64);
> +                       data_size += len; /* only dynamic string increments */
>                 } else {
>                         struct synth_field *field = state.event->fields[i];
>                         u64 val = vals[i];
> @@ -1510,6 +1622,11 @@ static int __synth_event_add_val(const char *field_name, u64 val,
>                 char *str_val = (char *)(long)val;
>                 char *str_field;
>
> +               if (field->is_dynamic) { /* add_val can't do dynamic strings */
> +                       ret = -EINVAL;
> +                       goto out;
> +               }
> +
>                 if (!str_val) {
>                         ret = -EINVAL;
>                         goto out;
> diff --git a/kernel/trace/trace_synth.h b/kernel/trace/trace_synth.h
> index 5166705d1556..6e146b959dcd 100644
> --- a/kernel/trace/trace_synth.h
> +++ b/kernel/trace/trace_synth.h
> @@ -16,6 +16,8 @@ struct synth_field {
>         unsigned int offset;
>         bool is_signed;
>         bool is_string;
> +       bool is_dynamic;
> +       bool field_pos;
>  };
>
>  struct synth_event {
> @@ -24,6 +26,8 @@ struct synth_event {
>         char                                    *name;
>         struct synth_field                      **fields;
>         unsigned int                            n_fields;
> +       struct synth_field                      **dynamic_fields;
> +       unsigned int                            n_dynamic_fields;
>         unsigned int                            n_u64;
>         struct trace_event_class                class;
>         struct trace_event_call                 call;
> --
> 2.17.1
>
